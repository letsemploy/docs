
# How to publish job openings

You need **your own website**: e.g. www.example.com, on which you publish your job vacancies as usual. This can be using Wordpress, another CMS, plain HTML or any other way.

Additionally, a well defined, structured file `ojobpub.json` with meta information about the job and with the link to the full job description is **published in a predefined subdirectory of your website** `/.well-known/ojobpub.json`.

## How ojobpub.json looks

This file is in a machine-optimized data format (JSON), but is still human-readable. It may look complicated to people who are unfamiliar with this data format, but don't worry: it is not intended to be written by hand by humans.

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

Not all of these properties you see are actual required to publish a valid file. But it is recommended to fill out as much meta information as you can. 

## JSON Schema

To validate the JSON data format, we created our own [oJobPub JSON schema](https://github.com/ojobpub/schema) and an app [https://validator.ojobpub.org](https://validator.ojobpub.org) to help validate the data file.
