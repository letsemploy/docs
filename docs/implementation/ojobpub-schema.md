---
hide:
- toc
---
# oJobPub - Open Job Publishing Initiative

Meta data format to publish open jobs on your website in a structured way.

### Type: `object`

> ⚠️ Additional properties are not allowed.

| Property | Type | Required | Possible values | Deprecated | Default | Description | Examples |
| -------- | ---- | -------- | --------------- | ---------- | ------- | ----------- | -------- |
| version | `const` | ✅ | `1.0` |  |  | Version of the oJobPub schema |  |
| lastUpdated | `string` | ✅ | Format: [`date-time`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the oJobPub feed was last updated |  |
| employer | `object` | ✅ | object |  |  | Information about the employer offering the job |  |
| employer.name | `string` | ✅ | Length: `1 <= string <= 255` |  |  | Employer's name |  |
| employer.location | `object` | ✅ | object |  |  | Location information |  |
| employer.location.city | `string` |  | string |  |  | City e.g. San Francisco |  |
| employer.location.country | `string` |  | Length: `2 <= string <= 2` |  |  | Country code as ISO 3166-1 alpha-2, e.g. US, DE, CH. Also see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 |  |
| employer.industry | `string` |  | Length: `1 <= string <= 255` |  |  | Industry of the employer, e.g. Software, Finance, Healthcare |  |
| employer.url | `string` |  | Format: [`uri`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Employer's main website URL, e.g. https://www.example.com |  |
| jobs | `array` | ✅ | object |  |  | List of job openings offered by the employer |  |
| jobs[].language | `string` | ✅ | Length: `2 <= string <= 2` |  |  | Language of the job description as ISO 639-1:2002. See https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes |  |
| jobs[].publishedAt | `string` | ✅ | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job was first published |  |
| jobs[].startDate | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job starts |  |
| jobs[].endDate | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job ends |  |
| jobs[].applyBefore | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date until the job is valid |  |
| jobs[].category | `string` |  | Length: `string <= 255` |  |  | Category of the job: e.g. Engineering, Marketing, Salesq |  |
| jobs[].referenceId | `string` |  | Length: `string <= 255` |  |  | Job reference identifier, e.g. internal job ID |  |
| jobs[].title | `string` | ✅ | Length: `string <= 255` |  |  | Title of the job |  |
| jobs[].description | `string` |  | Length: `string <= 1000` |  |  | Description of the job |  |
| jobs[].jobType | `string` | ✅ | `permanent` `contract` `internship` `apprenticeship` `temporary` `volunteer` `freelance` |  |  | Type of the job |  |
| jobs[].experienceLevel | `string` |  | `junior` `mid` `senior` `lead` `manager` `director` `executive` |  |  | Experience level required for the job |  |
| jobs[].workLoad | `object` |  | object |  |  | Expected workload in percentage for the job |  |
| jobs[].workLoad.minPercentage | `number` |  | `0 <= x <= 100` |  |  | Minimum expected workload in percentage |  |
| jobs[].workLoad.maxPercentage | `number` |  | `0 <= x <= 100` |  |  | Maximum expected workload in percentage |  |
| jobs[].workType | `string` |  | `remote` `on-site` `hybrid` |  |  | Type of work for the job |  |
| jobs[].salary | `object` |  | object |  |  | Salary range for the job |  |
| jobs[].salary.min | `number` |  | `0 <= x ` |  |  | Minimum salary to expect |  |
| jobs[].salary.max | `number` |  | `0 <= x ` |  |  | Maximum salary to expect |  |
| jobs[].salary.currency | `string` |  | Length: `3 <= string <= 3` |  |  | Currency as ISO 4217: see https://en.wikipedia.org/wiki/ISO_4217 |  |
| jobs[].salary.interval | `string` |  | `hourly` `daily` `weekly` `monthly` `yearly` |  |  | Min/max salary interval, e.g. per hour, per month, per year |  |
| jobs[].tags | `array` |  | Length: `string <= 28` |  |  | Key words for the job, e.g. skills, technologies, etc. |  |
| jobs[].locations | `array` | ✅ | object |  |  | Locations of the job |  |
| jobs[].locations[].city | `string` |  | string |  |  | City e.g. San Francisco |  |
| jobs[].locations[].country | `string` |  | Length: `2 <= string <= 2` |  |  | Country code as ISO 3166-1 alpha-2, e.g. US, DE, CH. Also see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 |  |
| jobs[].url | `string` | ✅ | Format: [`uri`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | URL of the job's full description and application page |  |


---

# Definitions

## location

Location information

#### Type: `object`

| Property | Type | Required | Possible values | Deprecated | Default | Description | Examples |
| -------- | ---- | -------- | --------------- | ---------- | ------- | ----------- | -------- |
| city | `string` |  | string |  |  | City e.g. San Francisco |  |
| country | `string` |  | Length: `2 <= string <= 2` |  |  | Country code as ISO 3166-1 alpha-2, e.g. US, DE, CH. Also see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 |  |

## job

Job opening information

#### Type: `object`

> ⚠️ Additional properties are not allowed.

| Property | Type | Required | Possible values | Deprecated | Default | Description | Examples |
| -------- | ---- | -------- | --------------- | ---------- | ------- | ----------- | -------- |
| language | `string` | ✅ | Length: `2 <= string <= 2` |  |  | Language of the job description as ISO 639-1:2002. See https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes |  |
| publishedAt | `string` | ✅ | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job was first published |  |
| title | `string` | ✅ | Length: `string <= 255` |  |  | Title of the job |  |
| jobType | `string` | ✅ | `permanent` `contract` `internship` `apprenticeship` `temporary` `volunteer` `freelance` |  |  | Type of the job |  |
| locations | `array` | ✅ | object |  |  | Locations of the job |  |
| locations[].city | `string` |  | string |  |  | City e.g. San Francisco |  |
| locations[].country | `string` |  | Length: `2 <= string <= 2` |  |  | Country code as ISO 3166-1 alpha-2, e.g. US, DE, CH. Also see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 |  |
| url | `string` | ✅ | Format: [`uri`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | URL of the job's full description and application page |  |
| startDate | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job starts |  |
| endDate | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date when the job ends |  |
| applyBefore | `string` |  | Format: [`date`](https://json-schema.org/understanding-json-schema/reference/string#built-in-formats) |  |  | Date until the job is valid |  |
| category | `string` |  | Length: `string <= 255` |  |  | Category of the job: e.g. Engineering, Marketing, Salesq |  |
| referenceId | `string` |  | Length: `string <= 255` |  |  | Job reference identifier, e.g. internal job ID |  |
| description | `string` |  | Length: `string <= 1000` |  |  | Description of the job |  |
| experienceLevel | `string` |  | `junior` `mid` `senior` `lead` `manager` `director` `executive` |  |  | Experience level required for the job |  |
| workLoad | `object` |  | object |  |  | Expected workload in percentage for the job |  |
| workLoad.minPercentage | `number` |  | `0 <= x <= 100` |  |  | Minimum expected workload in percentage |  |
| workLoad.maxPercentage | `number` |  | `0 <= x <= 100` |  |  | Maximum expected workload in percentage |  |
| workType | `string` |  | `remote` `on-site` `hybrid` |  |  | Type of work for the job |  |
| salary | `object` |  | object |  |  | Salary range for the job |  |
| salary.min | `number` |  | `0 <= x ` |  |  | Minimum salary to expect |  |
| salary.max | `number` |  | `0 <= x ` |  |  | Maximum salary to expect |  |
| salary.currency | `string` |  | Length: `3 <= string <= 3` |  |  | Currency as ISO 4217: see https://en.wikipedia.org/wiki/ISO_4217 |  |
| salary.interval | `string` |  | `hourly` `daily` `weekly` `monthly` `yearly` |  |  | Min/max salary interval, e.g. per hour, per month, per year |  |
| tags | `array` |  | Length: `string <= 28` |  |  | Key words for the job, e.g. skills, technologies, etc. |  |
