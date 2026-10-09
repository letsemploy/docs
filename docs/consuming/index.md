# Consuming

This page covers how to get oJobPub data into your job board, search engine or tool. There are two options:

- **Aggregated**: download the daily export from [SourceTracker](../resources/sourcetracker.md). It contains every feed that passed validation.
- **Direct**: fetch `https://<domain>/.well-known/ojobpub.json` from each publisher yourself.

For a working consumer, see [Job Search](../resources/jobsearch.md) at [jobs.letsemploy.org](https://jobs.letsemploy.org). It checks for a new export every 3 hours and makes the jobs searchable.

## API token

The export and the GraphQL API require a free API token. [Sign up](https://sources.letsemploy.org/signup), create a token on your [account page](https://sources.letsemploy.org/account) and send it as a bearer token. The examples below expect it in `$ST_TOKEN`:

```sh
export ST_TOKEN=st_...
```

See [SourceTracker](../resources/sourcetracker.md#accounts-and-api-tokens) for the limits.

## Daily export

Once a day, SourceTracker builds an XZ-compressed tar archive with the feeds of all healthy sources:

- Name: `letsemploy-ojobpub-<YYYY-MM-DD>.tar.xz`
- Content: one `<domain>.json` per source, sorted by domain, each a complete oJobPub document
- Retention: 30 days

```sh
curl -sSLOJ -H "Authorization: Bearer $ST_TOKEN" \
  https://sources.letsemploy.org/exports/download-latest
tar -xJf letsemploy-ojobpub-*.tar.xz -C feeds/
jq -r '.jobs[] | [.title, .url] | @tsv' feeds/example.com.json
```

Older artifacts are listed at [sources.letsemploy.org/exports](https://sources.letsemploy.org/exports) and can be downloaded via `/exports/{id}/download`.

Each token can download 50 exports per UTC day. Downloads send `ETag` and `Last-Modified`, and a conditional request that returns `304 Not Modified` doesn't count, so poll with `If-None-Match` or `If-Modified-Since` (e.g. `curl -z <file>`).

## GraphQL API

The read-only API at `https://sources.letsemploy.org/graphql` exposes source, probe, export and statistics **metadata**, e.g. health status, job count, content hash and schema version. It doesn't return feed contents. Use it to find changed sources or new exports. Explore it in [GraphiQL](https://sources.letsemploy.org/graphiql?path=/graphql) while signed in.

```graphql
{
  latestExport { artifactName sizeBytes createdAt downloadUrl }
  sources(page: 0, size: 100, status: HEALTHY, sort: DOMAIN) {
    items { domain status jobsCount lastHashChangedAt }
    pageInfo { totalPages hasNext }
  }
  dailyStats(metric: SOURCE_TOTAL_JOBS, days: 30) { date value }
}
```

```sh
curl -s https://sources.letsemploy.org/graphql \
  -H "Authorization: Bearer $ST_TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{"query":"{ latestExport { artifactName downloadUrl } }"}'
```

- `sources` takes an optional `query` (domain substring), `status` (`HEALTHY`, `UNHEALTHY`, `SUSPENDED`) and `sort` (`NEWEST`, `DOMAIN`, `LAST_VISITED`, `JOBS`, `STATUS_CHANGED`).
- `dailyStats` metrics: `SOURCE_TOTAL_JOBS`, `SOURCE_HEALTHY`, `SOURCE_UNHEALTHY`, `SOURCE_PENDING`, `SOURCE_SUSPENDED`, `EXPORT_DOWNLOADS_TOTAL`.
- Collections are paged (`page` starts at 0, default `size` is 20, maximum 100).
- Each token allows 10,000 requests per day and 60 per minute.

For the status of a single domain, the public [status API](../resources/sourcetracker.md#status-api-and-badge) needs no token.

## Fetching feeds directly

To fetch feeds directly, follow the discovery rules in the [specification](../ojobpub/specification.md#3-discovery-and-publication):

- Request `https://<domain>/.well-known/ojobpub.json` on the apex domain and follow redirects (limit them, e.g. to 5).
- Send an identifying `User-Agent` with a contact URL.
- Poll no more than once a day, and skip unchanged documents (compare `lastUpdated` or a content hash).

## Processing rules

- **Validate** every document against the [schema](https://github.com/letsemploy/schema) and reject documents with an unsupported `version`.
- **Treat `url` as untrusted input.** Allow only `https`/`http` schemes, and apply your usual link-safety checks. The job URL may point to a domain other than the feed's.
- **Treat text fields as plain text.** Escape `title`, `description` and `tags` before rendering.
- **Link back.** The job `url` is the canonical page for the full description and the application. Don't collect applications on the publisher's behalf.
- **Expire jobs.** Drop a job when it no longer appears in the feed, or after `applyBefore` has passed.
