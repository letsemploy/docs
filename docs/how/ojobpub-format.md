
# oJobPub JSON File Format

!!! note
    JSON might look complicated if you're not familiar with it, but don't worry — you won't have to write it yourself. Once this format is finalized, we'll provide tools to help you generate and validate the structure.

```json
{
    "employer": {
        "name": "Acme Corp",
        "location": {
            "city": "New York",
            "country": "US"
        },
        "industry": "Software",
        "url": "https://example.com"
    },
    "vacancies": [
        {
            "jobTitle": "Software Engineer",
            "jobRef": "SE-001",
            "applyBefore": "2026-12-31",
            "language": "en",
            "jobDescription": "Develop and maintain software applications.",
            "jobType": "contract",
            "workType": "hybrid",
            "experienceLevel": "mid",
            "workLoad": {
                "minPercentage": 80,
                "maxPercentage": 100
            },
            "tags": ["python", "flask", "backend"],
            "location": {
                "city": "Amsterdam",
                "country": "NL"
            },
            "jobUrl": "https://example.com/job/1"
        }
    ]
}
```

1. The `employer` json object with minimal information about the employer.
2. The list of `vacancies` objects with meta information about the job openings.

!!! tip 
    While not all properties are required for a valid file, we highly recommend you fill out as much metadata as possible.
