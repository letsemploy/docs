# oJobPub Format

Below you find a sample, how a ojobpub.json might look like. This is really just one example and is neither exhaustive nor self-explanatory. An explanation of the fields can be found at [oJobPub JSON Schema](./schema.md).

!!! note
    JSON might look complicated if you're not familiar with it, but don't worry — you won't have to write it by hand. Once this format is finalized, we'll provide tools to help you generate and validate the structure.


## Sample

```json
{
    "version": "1.0",
    "lastUpdated": "2025-09-13T12:00:00Z",
    "employer": {
        "name": "Acme Corp",
        "location": {
            "city": "New York",
            "country": "US"
        },
        "industry": "Software",
        "url": "https://example.com"
    },
    "jobs": [
        {
            "publishedAt": "2025-08-30",
            "category": "Engineering",
            "title": "Software Engineer",
            "referenceId": "SE-2023-001",
            "applyBefore": "2026-12-31",
            "language": "en",
            "description": "Develop and maintain software applications.",
            "jobType": "permanent",
            "workType": "hybrid",
            "experienceLevel": "mid",
            "workLoad": {
                "minPercentage": 80,
                "maxPercentage": 100
            },
            "tags": ["python", "flask", "backend"],
            "locations":
            [
                {
                    "city": "New York",
                    "country": "US"
                },
                {
                    "city": "San Francisco",
                    "country": "US"
                }
            ],
            "salary": {
                "minAmount": 70000,
                "maxAmount": 120000,
                "currency": "USD",
                "period": "yearly"
            },
            "url": "https://example.com/job/1"
        }
    ]
}
```

1. The `employer` json object with minimal information about the employer.
2. The list of `jobs` objects with meta information about the job openings.

Some of the (blue) keys (e.g. `workload` or `description`) are optional while others are required (e.g. `title`).

!!! tip
    While not all properties are required for a valid file, we highly recommend you fill out as much metadata as possible.
