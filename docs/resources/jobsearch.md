# Job Search

| | |
| --- | --- |
| Website | [jobs.letsemploy.org](https://jobs.letsemploy.org) |
| API | [REST](#api) (public), [OpenAPI UI](https://jobs.letsemploy.org/api/docs) |
| Feed | [RSS](#rss) |
| Status | stable, best effort |

Job Search is a free search over all jobs in the [SourceTracker](sourcetracker.md) export. It shows what consumers can build on oJobPub. It doesn't host job ads or collect applications. Every listing links back to the job `url` on the employer's site.

## Features

- Full-text, typo-tolerant search with results as you type
- Filters for country, tags, job type, work type and experience level, with counts
- Job details with the employer's icon
- Shareable search URLs and an RSS feed per search
- English and German, light and dark theme

## Data

Job Search checks for a new [daily export](../consuming/index.md#daily-export) every 3 hours and updates the index per domain:

- Jobs of domains that are no longer in the export are removed. An empty or broken export never clears the index.
- Each job `url` is fetched with the user agent `minisearch (+https://letsemploy.org)`. If it returns HTML with status 200, the page text is indexed to improve search. It is never shown, except for a short excerpt when the job has no `description`.
- Only public addresses are fetched.

Your listings appear here automatically once your domain is [registered](../publishing/register.md) and healthy.

## API

The read-only JSON API needs no token. Filters use the same values as the [field reference](../ojobpub/schema.md), e.g. `CH`, `permanent` or `remote`.

```sh
curl -s 'https://jobs.letsemploy.org/api/v1/jobs?q=engineer&countries=CH&workTypes=remote&limit=20'
```

| Endpoint | Returns |
| --- | --- |
| `GET /api/v1/jobs` | `hits`, `total`, `offset`, `limit`, `facets` (counts for this query), `facetTotals` (counts across all jobs) |
| `GET /api/v1/jobs/{id}` | One job, or `404` |
| `GET /api/v1/health` | `{status, meilisearch}`, or `503` when degraded |

| Parameter | Description |
| --- | --- |
| `q` | Search text |
| `countries`, `tags`, `jobTypes`, `workTypes`, `experienceLevels` | Filters, repeatable. Values of one filter are OR-ed, different filters are AND-ed |
| `offset` | Start index, default `0` |
| `limit` | Page size, `1` to `50`, default `10` |

The OpenAPI schema is at [`/api/openapi.json`](https://jobs.letsemploy.org/api/openapi.json).

## RSS

`/feed.xml` returns the 50 most recently added jobs as RSS 2.0. It takes the same parameters as the search, e.g.:

```
https://jobs.letsemploy.org/feed.xml?countries=CH&tags=python
```

## Self-hosting

Job Search runs as one container next to [Meilisearch](https://www.meilisearch.com). It needs a SourceTracker [API token](sourcetracker.md#accounts-and-api-tokens) to download the export. The repository contains a `docker-compose.yml`:

```sh
git clone https://github.com/letsemploy/minisearch.git && cd minisearch
DOWNLOAD_TOKEN=st_... docker compose up -d   # UI on http://localhost:8001
```

| Variable | Default | Purpose |
| --- | --- | --- |
| `DOWNLOAD_TOKEN` | – | SourceTracker API token (required) |
| `MEILI_URL` | `http://127.0.0.1:7700` | Meilisearch address |
| `MEILI_KEY` | `masterkey` | Meilisearch key, change it |
| `SYNC_INTERVAL_HOURS` | `3` | Hours between export checks |
| `SCRAPE_ENABLED` | `true` | Fetch job pages for search text |
| `ICONS_MODE` | `local` | Employer icons: `off`, `proxy`, `local` or `s3` |

All variables are listed in the [repository README](https://github.com/letsemploy/minisearch#configuration).
