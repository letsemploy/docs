# oJobPub JSON Standard

- **Document Version**:  1.0.0-draft.1
- **Status**:            Draft
- **Modification Date**: 2026-06-24


## Pupose of Document

This document defines version 1.0 of the oJobPub JSON standard as documented by LetsEmploy.org.


## Abstract

The oJobPub JSON standard defines a minimal, machine-readable format for publishing job openings on a website. Publishers expose a single JSON document at a well-known URL, and consumers retrieve and validate that document to discover job metadata.

## 1. Introduction

oJobPub provides a compact interoperability layer for open job publishing.

A publisher keeps full job descriptions on normal web pages and exposes structured metadata in an `ojobpub.json` document. This document is intended for indexing, discovery, and automation.

## 2. Conventions and Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119 and RFC 8174.

### 2.1 Terms

- Publisher: The website owner publishing the oJobPub document.
- Consumer: A service or application retrieving and processing oJobPub documents.
- Feed: The oJobPub JSON document.
- Job URL: The canonical URL to the full job description and application page.

## 3. Discovery and Publication

### 3.1 Well-Known Path

A publisher MUST make the feed available at:

`https://<domain>/.well-known/ojobpub.json`

Example:

`https://example.com/.well-known/ojobpub.json`

Also see [IANA Well-Known URIs](https://www.iana.org/assignments/well-known-uris/well-known-uris.xhtml).


### 3.2 Domain and Redirect Behavior

The canonical discovery URL is defined on the domain without the `www` prefix. HTTP redirects are allowed, including redirects to another host or path, provided the final target resolves to a valid oJobPub JSON document.

If redirects are used, publishers SHOULD preserve an explicit path to `ojobpub.json` at the target location.

### 3.3 Transport and Content

The feed MUST be served over HTTPS.

The payload MUST be valid JSON. Publishers SHOULD serve it with media type `application/json`.

## 4. Data Model Overview

An oJobPub feed is a top-level JSON object with this structure:

- `version` (required, constant `1.0`)
- `lastUpdated` (required, date-time string)
- `employer` (required, object)
- `jobs` (required, array of job objects)

Additional properties at the top level are not allowed.

## 5. Top-Level Object Definition

### 5.1 `version`

- Type: string constant
- Required: yes
- Value: `1.0`

### 5.2 `lastUpdated`

- Type: string
- Required: yes
- Format: JSON Schema `date-time`
- Meaning: last update timestamp for the feed

### 5.3 `employer`

- Type: object
- Required: yes
- Meaning: metadata about the employer

Properties:

- `name` (required): string, length 1..255
- `location` (required): `location` object
- `industry` (optional): string, length 1..255
- `url` (optional): string, JSON Schema `uri`

### 5.4 `jobs`

- Type: array of `job` objects
- Required: yes
- Meaning: list of job openings

## 6. Reusable Objects

### 6.1 `location` object

Properties:

- `city` (optional): string
- `country` (optional): string, exactly 2 characters, ISO 3166-1 alpha-2 (for example `US`, `DE`, `CH`)

## 7. `job` Object Definition

Each entry in `jobs` is a `job` object.

Additional properties in a `job` object are not allowed.

### 7.1 Required Properties

- `language`: string, exactly 2 characters, ISO 639-1 code
- `publishedAt`: string, JSON Schema `date`
- `title`: string, max length 255
- `jobType`: string enum
- `locations`: array of `location` objects
- `url`: string, JSON Schema `uri`

### 7.2 Optional Properties

- `startDate`: string, JSON Schema `date`
- `endDate`: string, JSON Schema `date`
- `applyBefore`: string, JSON Schema `date`
- `category`: string, max length 255
- `referenceId`: string, max length 255
- `description`: string, max length 1000
- `experienceLevel`: string enum
- `workLoad`: object
- `workType`: string enum
- `salary`: object
- `tags`: array of strings, each max length 28

### 7.3 Enumerations

#### 7.3.1 `jobType`

Allowed values:

- `permanent`
- `contract`
- `internship`
- `apprenticeship`
- `temporary`
- `volunteer`
- `freelance`

#### 7.3.2 `experienceLevel`

Allowed values:

- `junior`
- `mid`
- `senior`
- `lead`
- `manager`
- `director`
- `executive`

#### 7.3.3 `workType`

Allowed values:

- `remote`
- `on-site`
- `hybrid`

#### 7.3.4 `salary.interval`

Allowed values:

- `hourly`
- `daily`
- `weekly`
- `monthly`
- `yearly`

### 7.4 Nested Optional Objects

#### 7.4.1 `workLoad`

- `minPercentage`: number, range 0..100
- `maxPercentage`: number, range 0..100

#### 7.4.2 `salary`

- `min`: number, minimum 0
- `max`: number, minimum 0
- `currency`: string, exactly 3 characters, ISO 4217
- `interval`: enum from Section 7.3.4

## 8. Validation and Conformance

A publisher implementation conforms to this specification if:

- the feed is discoverable at the URL in Section 3.1 (or via HTTP redirect from that URL), and
- the JSON instance validates against schema version `1.0` with the constraints defined in this document.

A consumer SHOULD validate incoming feeds before processing them.

The reference schema and validation tooling are available at:

- Schema repository: `https://github.com/letsemploy/schema`
- Online validator: `https://validator.letsemploy.org`

## 9. Operational Guidance

- Publishers MUST keep `lastUpdated` accurate whenever feed content changes.
- Publishers SHOULD populate as many optional fields as practical to improve matching and discoverability.
- Each job entry MUST set `url` to a publicly accessible page that SHOULD includes the complete job description and application details. The `url` MAY reference a domain different from the one hosting `.well-known/ojobpub.json`.

## 10. Security and Privacy Considerations

- Publishers SHOULD avoid exposing personal data in feed fields unless required by local law or explicit business need.
- Consumers MUST treat external `url` values as untrusted input and apply normal URL safety controls.
- Publishers and consumers SHOULD use TLS best practices and current certificates for HTTPS endpoints.

## 11. Example

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
      "locations": [
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
        "min": 70000,
        "max": 120000,
        "currency": "USD",
        "interval": "yearly"
      },
      "url": "https://example.com/job/1"
    }
  ]
}
```

## 12. References

### 12.1 Normative References

- RFC 2119: Key words for use in RFCs to Indicate Requirement Levels
- RFC 8174: Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words
- JSON Schema Core and Validation specifications

### 12.2 Informative References

- LetsEmploy.org Docs: [https://docs.letsemploy.org](https://docs.letsemploy.org)
- oJobPub Docs: [https://docs.letsemploy.org/ojobpub/](https://docs.letsemploy.org/ojobpub/)
- About JSON: [https://www.json.org](https://www.json.org)
- About Well-Known URI concept: [https://en.wikipedia.org/wiki/Well-known_URI](https://en.wikipedia.org/wiki/Well-known_URI)
