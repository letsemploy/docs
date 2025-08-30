# oJobPub JSON Format

Before we go to oJobPub JSON, let's clearify two terms:

- JSON
- JSON Schema

## What is JSON

JSON (JavaScript Object Notation) is an open, lightweight, text-based data structure format used to store and interchange data. Primarly for machines to write and read while still writable and readable by humans. 

## What is a JSON Schema

[JSON Schema](https://json-schema.org) is an IETF standard providing a format for what JSON data is required for a given application and how to interact with it. Applying such standards for a JSON document enforce consistency and data validity,

## oJobPub JSON

oJobPub is meant to be minimalistic, mainly containing meta infos about the job and a short summary. It is not meant to have all possible data of a job posting: e.g. the process of application is and will not be covered.

!!! note
    JSON might look complicated if you're not familiar with it, but don't worry — you won't have to write it by hand. Once this format is finalized, we'll provide tools to help you generate and validate the structure.

An possible output could look like this, however, some of the (blue) keys (e.g. `workload` or `jobDescription`) are optional while others are required (e.g. `jobTitle`). This is why we also provide a [oJobPub JSON Schema](https://raw.githubusercontent.com/ojobpub/schema/refs/heads/main/v1/ojobpub.json) and an online validator tool [validator.ojobpub.org](https://validator.ojobpub.org) verify your written oJobPub JSON.

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
