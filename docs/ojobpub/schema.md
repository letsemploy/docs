# Field Reference

All properties of oJobPub `1.0`. The normative rules are in the [specification](specification.md), and the machine-readable definition is the [JSON Schema](https://github.com/letsemploy/schema/blob/main/v1/ojobpub.json).

Formats: `date` is `YYYY-MM-DD`, `date-time` is RFC 3339 (e.g. `2026-09-01T08:00:00Z`), `uri` is an absolute URI.

## Feed

Top-level object. Additional properties are not allowed.

| Field | Type | Req | Constraints | Notes |
| --- | --- | :-: | --- | --- |
| `version` | string | ✓ | const `"1.0"` | Schema version |
| `lastUpdated` | string | ✓ | `date-time` | Last change of the feed content |
| `employer` | [employer](#employer) | ✓ | | |
| `jobs` | array of [job](#job) | ✓ | may be empty | |

## employer

Additional properties are not allowed.

| Field | Type | Req | Constraints | Notes |
| --- | --- | :-: | --- | --- |
| `name` | string | ✓ | 1–255 chars | |
| `location` | [location](#location) | ✓ | | Headquarters |
| `industry` | string | | 1–255 chars | e.g. `Software`, `Healthcare` |
| `url` | string | | `uri` | Main website |

```json
"employer": {
  "name": "Acme Corp",
  "location": { "city": "Zurich", "country": "CH" },
  "industry": "Software",
  "url": "https://example.com"
}
```

## job

Additional properties are not allowed.

| Field | Type | Req | Constraints | Notes |
| --- | --- | :-: | --- | --- |
| `title` | string | ✓ | ≤ 255 chars | |
| `language` | string | ✓ | 2 chars, ISO 639-1 | Language of the job posting, e.g. `en`, `de` |
| `publishedAt` | string | ✓ | `date` | First publication |
| `jobType` | string | ✓ | `permanent` `contract` `internship` `apprenticeship` `temporary` `volunteer` `freelance` | |
| `locations` | array of [location](#location) | ✓ | ≥ 1 item | |
| `url` | string | ✓ | `uri` | Canonical page with full description and application details |
| `description` | string | | ≤ 1000 chars | Plain-text summary, no HTML |
| `category` | string | | ≤ 255 chars | e.g. `Engineering` |
| `referenceId` | string | | ≤ 255 chars | Your internal job ID |
| `applyBefore` | string | | `date` | Application deadline |
| `startDate` | string | | `date` | |
| `endDate` | string | | `date` | For fixed-term positions |
| `workType` | string | | `remote` `on-site` `hybrid` | |
| `experienceLevel` | string | | `junior` `mid` `senior` `lead` `manager` `director` `executive` | |
| `workLoad` | [workLoad](#workload) | | | |
| `salary` | [salary](#salary) | | | |
| `tags` | array of string | | ≤ 16 items, unique, each ≤ 28 chars | Skills, technologies |

## location

Used by `employer.location` and `job.locations[]`.

| Field | Type | Req | Constraints | Notes |
| --- | --- | :-: | --- | --- |
| `city` | string | | | |
| `country` | string | | 2 chars, ISO 3166-1 alpha-2 | e.g. `US`, `DE`, `CH` |

```json
{ "city": "Berlin", "country": "DE" }
```

## workLoad

Workload as a percentage of full time.

| Field | Type | Req | Constraints |
| --- | --- | :-: | --- |
| `minPercentage` | number | | 0–100 |
| `maxPercentage` | number | | 0–100 |

```json
"workLoad": { "minPercentage": 80, "maxPercentage": 100 }
```

## salary

| Field | Type | Req | Constraints | Notes |
| --- | --- | :-: | --- | --- |
| `min` | number | | ≥ 0 | |
| `max` | number | | ≥ 0 | |
| `currency` | string | | 3 chars, ISO 4217 | e.g. `CHF`, `EUR`, `USD` |
| `interval` | string | | `hourly` `daily` `weekly` `monthly` `yearly` | Period `min`/`max` refer to |

```json
"salary": { "min": 90000, "max": 110000, "currency": "CHF", "interval": "yearly" }
```
