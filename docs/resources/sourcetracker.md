# SourceTracker

| | |
| --- | --- |
| Website | [sources.letsemploy.org](https://sources.letsemploy.org) |
| API | [GraphQL](https://sources.letsemploy.org/graphiql?path=/graphql) (token), [status endpoints](#status-api-and-badge) (public) |
| Export | [/exports/download-latest](https://sources.letsemploy.org/exports/download-latest) (token) |
| Status | Stable, best effort |

SourceTracker keeps a register of domains that publish oJobPub, validates each feed periodically, and publishes the feeds of healthy domains as a daily export. It is not a job board. It doesn't search, rank or normalize jobs. For a search over the export, see [Job Search](jobsearch.md).

## Sources

A source is a registrable domain such as `example.com`. SourceTracker rejects subdomains (`www.example.com`, `jobs.example.com`). Anyone can [register a domain](https://sources.letsemploy.org/sources/new). Registration is protected by a captcha and limited to 10 per hour per client. Domain ownership is not verified: a domain only enters the register once its own feed passes every check.

## Probes

A probe fetches `https://<domain>/.well-known/ojobpub.json` with:

- a connect and read timeout of 5 s and an overall deadline of 20 s,
- a maximum response size of 10 MB,
- at most 5 redirects (301, 302, 303, 307, 308), each to `http`/`https` on a default port and a public address,
- the user agent `oJobPub-SourceTracker/1.0`.

It then runs these checks in order:

| # | Check | Passes when |
| --- | --- | --- |
| 1 | `dns-address-record-check` | The domain resolves to an address, with `www.` tried as a fallback |
| 2 | `json-downloadable-check` | The response status is 2xx |
| 3 | `json-valid-check` | The body parses as JSON |
| 4 | `schema-version-valid-check` | `version` is supported (`1.0`) and the document validates against the schema |
| 5 | `job-description-policy-check` | No `description` contains HTML tags, `<script`, `javascript:` URLs, inline `on*=` handlers or spam/adult-content terms |

A probe succeeds only if every check passes. A check that is skipped because an earlier one failed counts as a failure. The source page lists each check's result and details.

## Lifecycle

| Status | Meaning | Next probe |
| --- | --- | --- |
| `PENDING` | Newly registered candidate, not yet in the register | Immediately, then every 1 h |
| `HEALTHY` | The last probe succeeded | After 24 h |
| `UNHEALTHY` | The last probe failed | After 1 h |
| `SUSPENDED` | 10 consecutive probes failed | After 7 days |

- A `PENDING` candidate is hidden from the list, the API and the export. The first probe that passes every check admits it as `HEALTHY`. A candidate that isn't admitted within 24 h of registration is deleted.
- Only `HEALTHY` sources are included in the export. `UNHEALTHY` and `SUSPENDED` sources stay listed.
- A suspended source is reinstated automatically as soon as a probe passes again. Sources suspended for more than 180 days are removed. You can register them again at any time.
- Anyone can request an earlier revisit from the source page. The probe is then moved up to within 10 minutes (limited to 30 requests per hour per client).
- SourceTracker stores a new document only when its SHA-256 hash changes.

## Accounts and API tokens

The export and the GraphQL API require an API token:

1. [Sign up](https://sources.letsemploy.org/signup) and verify your e-mail address.
2. Create a token on your [account page](https://sources.letsemploy.org/account). The secret (`st_…`) is shown only once. An account can hold up to 5 active tokens.
3. Send it as `Authorization: Bearer st_…`.

| Limit | Default per token |
| --- | --- |
| GraphQL requests | 10,000 per day, 60 per minute |
| Export downloads | 50 per UTC day (a `304 Not Modified` is free) |

Requests over a limit get `429 Too Many Requests` with a `Retry-After` header. Requests without a valid token get `401`.

## Status API and badge

Two public endpoints, without a token, report the status of a single domain. Responses are cached for 5 minutes and allow cross-origin requests.

```sh
curl -s https://sources.letsemploy.org/api/sources/example.com
```

```json
{
  "domain": "example.com",
  "status": "HEALTHY",
  "lastVisitedAt": "2026-10-08T06:12:03Z",
  "nextVisitAt": "2026-10-09T06:12:03Z",
  "lastStatusChangedAt": "2026-09-01T10:00:00Z",
  "jobsCount": 12,
  "schemaVersion": "1.0"
}
```

Unknown and `PENDING` domains return `404`. The badge always returns `200` and reads `healthy`, `unhealthy`, `suspended` or `unknown`:

```html
<img src="https://sources.letsemploy.org/api/sources/example.com/badge.svg" alt="oJobPub status">
```

## Export

Every day, the feeds of all healthy sources are packed into `letsemploy-ojobpub-<YYYY-MM-DD>.tar.xz`, with one `<domain>.json` per source. Exports are kept for 30 days. Downloads require a token and support `ETag`/`Last-Modified` for conditional requests. See [Consuming](../consuming/index.md#daily-export) for usage.

## Statistics

The [dashboard](https://sources.letsemploy.org) charts sources, jobs and downloads over 30, 90 or 365 days. The underlying series are public JSON at `/stats/series/sources`, `/stats/series/artifacts` and `/stats/series/downloads`. Via GraphQL, `dailyStats(metric, days)` returns the same daily snapshots.
