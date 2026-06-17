# SourceTracker

| Info    |         |
| ------- | ------- |
| Website | [https://sources.letsemploy.org](https://sources.letsemploy.org) |
| API | [GraphQL](https://sources.letsemploy.org/graphiql?path=/graphql) |
| Status | Public BETA |
| Availablity | Best Effort |

## About

SourceTracker is free service by letsemploy.org. It is responsible for periodically checking and validating the availability of oJobPub data across all known domains.

## Exports

It generates an export of validated oJobPub data from all healthy domains daily. Find the latest data here [/exports/download-latest](https://sources.letsemploy.org/exports/download-latest)

## Lifecycle

Every domain will be visited daily, the content of the ojobpub.json will be downloaded and validated.

If the data passes the checks, the domain's status is marked as HEALTHY. In case of any failing check, the domain is maked as UNHEALTHY. Unhealthy domains will be revisited more frequently. In case the domain remains unhealthy, it may get susbended after a while or even removed from the index. Resubmition is possible at any time later.

## Checks

There are verious checks which defines if a domain is healthy or unhealthy:

- Domain and web server is reachable
- oJobPub format is accessible and valid
- Content passes abuse checks

More checks may be added in the future.

## Changelog

- 2026-06-01: Public Beta
