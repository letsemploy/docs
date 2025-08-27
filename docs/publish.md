
# How to publish job openings

## 1. Website
You need **your own website**: e.g. www.example.com, on which you publish your job openings as usual. This can be using Wordpress, another CMS, plain HTML or any other way.

## 2. Create a ojobpub.json
Create file `/.well-known/ojobpub.json` in a **specific JSON format containing structured meta information** about your job openings and link to the full job description on your website.

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

## 3. Validate

To validate the JSON data format, we provide a [oJobPub JSON schema](https://github.com/ojobpub/schema) and an app [https://validator.ojobpub.org](https://validator.ojobpub.org) to help validate the data file.
