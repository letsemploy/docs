# Create the Feed

An oJobPub feed is a JSON object containing employer metadata and a list of jobs. See the [field reference](../ojobpub/schema.md) for all properties.

## Minimal example

Only required fields:

```json
{
  "version": "1.0",
  "lastUpdated": "2026-09-01T08:00:00Z",
  "employer": {
    "name": "Example Ltd",
    "location": { "city": "Bern", "country": "CH" }
  },
  "jobs": [
    {
      "title": "Carpenter",
      "language": "en",
      "publishedAt": "2026-09-01",
      "jobType": "permanent",
      "locations": [{ "city": "Bern", "country": "CH" }],
      "url": "https://example.com/jobs/carpenter"
    }
  ]
}
```

With no open positions, publish the feed with an empty list: `"jobs": []`. That keeps the domain healthy in SourceTracker, and consumers can tell "no openings" apart from "no feed".

## Static or generated

The feed doesn't have to be a static file. Any endpoint that returns the document works, for example:

- a file written by a CI job or build step (static site generators),
- a route in your CMS or application that renders it from the database,
- an export from your applicant tracking system, uploaded to object storage.

[Publisher](../resources/publisher.md) does this for you: manage jobs in a web UI and get a feed URL, either on the hosted instance or on your own server.

## Validate

Validate against the [JSON Schema](https://github.com/letsemploy/schema) before publishing. You can do it locally:

```sh
pip install check-jsonschema
check-jsonschema \
  --schemafile https://raw.githubusercontent.com/letsemploy/schema/main/v1/ojobpub.json \
  ojobpub.json
```

Or paste the document into the online [Validator](https://validator.letsemploy.org).

## Common mistakes

| Mistake | Correct |
| --- | --- |
| `"version": 1.0` (number) | `"version": "1.0"` (string) |
| Unknown properties such as `salaryText`, `email` | Additional properties are rejected at the top level, in `employer` and in `job` |
| `"country": "Switzerland"` | ISO 3166-1 alpha-2: `"CH"` |
| `"language": "en-US"` | ISO 639-1: `"en"` |
| `"publishedAt": "2026-09-01T08:00:00Z"` | `date` format: `"2026-09-01"` (only `lastUpdated` is `date-time`) |
| HTML in `description` | Plain text only. SourceTracker rejects markup and scripts |
| Stale `lastUpdated` | Update it on every content change |
| `"locations": []` | At least one location is required |
