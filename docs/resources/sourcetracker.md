# SourceTracker

| | |
| --- | --- |
| Website | [sources.letsemploy.org](https://sources.letsemploy.org) |
| API | [GraphQL](https://sources.letsemploy.org/graphiql?path=/graphql) (read-only) |
| Export | [/exports/download-latest](https://sources.letsemploy.org/exports/download-latest) |
| Status | Public beta, best effort |

SourceTracker keeps a register of domains that publish oJobPub, validates each feed periodically, and publishes the feeds of healthy domains as a daily export. It is not a job board. It doesn't search, rank or normalize jobs.

## Sources

A source is a registrable domain such as `example.com`. SourceTracker rejects subdomains (`www.example.com`, `jobs.example.com`). Anyone can [register a domain](https://sources.letsemploy.org/sources/new). Registration is protected by a captcha.

## Probes

A probe fetches `https://<domain>/.well-known/ojobpub.json` with:

- a connect and read timeout of 5 s,
- at most 5 redirects,
- the user agent `oJobPub-SourceTracker/1.0`.

It then runs these checks in order:

| # | Check | Passes when |
| --- | --- | --- |
| 1 | `dns-address-record-check` | The domain resolves to an address, with `www.` tried as a fallback |
| 2 | `json-downloadable-check` | The response status is 2xx |
| 3 | `json-valid-check` | The body parses as JSON |
| 4 | `schema-version-valid-check` | `version` is supported (`1.0`) and the document validates against the schema |
| 5 | `job-description-policy-check` | No `description` contains HTML, script or spam/adult-content terms |

A probe succeeds only if every check passes. A check that is skipped because an earlier one failed counts as a failure. The source page lists each check's result and details.

## Lifecycle

| Status | Meaning | Next probe |
| --- | --- | --- |
| `UNKNOWN` | Newly registered, not probed yet | Immediately after registration |
| `HEALTHY` | The last probe succeeded | After 24 h |
| `UNHEALTHY` | The last probe failed | After 1 h |

- Anyone can request an earlier revisit from the source page. The probe is then moved up to within 10 minutes.
- SourceTracker stores a new document only when its SHA-256 hash changes.
- Sources that stay unhealthy for 30 days are removed. You can register them again at any time.

## Export

Every day, the feeds of all healthy sources are packed into `letsemploy-ojobpub-<YYYY-MM-DD>.tar.xz`, with one `<domain>.json` per source. Exports are kept for 30 days. See [Consuming](../consuming/index.md#daily-export) for usage.
