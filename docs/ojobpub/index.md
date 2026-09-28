# oJobPub

oJobPub (Open Job Publishing) is a minimal JSON format for job openings, served at a well-known URL on the employer's domain.

| | |
| --- | --- |
| Current version | `1.0` (document `1.0.0-draft.1`) |
| Status | Draft, open for [feedback](https://github.com/letsemploy/docs/discussions) |
| Location | `https://<domain>/.well-known/ojobpub.json` |
| Schema | [JSON Schema draft 2020-12](https://github.com/letsemploy/schema/blob/main/v1/ojobpub.json), licensed CC0 |

- [Specification](specification.md): normative rules for publishers and consumers.
- [Field reference](schema.md): all properties with types and constraints.
- [Validator](https://validator.letsemploy.org): validate a document online.

## Design notes

**Well-known location.** Like `robots.txt` or `sitemap.xml`, the feed has a fixed path ([RFC 8615](https://www.rfc-editor.org/rfc/rfc8615)). A consumer only needs a domain name to find all its openings. It doesn't have to crawl the site or guess URLs.

**One document per domain.** A single request returns all openings of an employer. Change detection is possible with `lastUpdated` or a content hash.

**Minimal metadata.** The feed carries only what is needed for search and filtering: title, type, location, language, dates, and optionally workload and salary. The full description and the application process stay on the employer's job page, which the `url` field references. This keeps the format small and stable, and keeps the employer in control of the content after it has been indexed.

**Strict schema.** `additionalProperties: false` on the feed, `employer` and `job` objects rejects typos and vendor-specific extensions early, so all consumers get the same interpretation.

## Relation to other formats

- **schema.org [JobPosting](https://schema.org/JobPosting)** describes a single job page and is embedded in its HTML. It is complementary: keep JobPosting markup on the page that the oJobPub `url` points to.
- **sitemap.xml** lists URLs but not their meaning. oJobPub lists the job pages together with their structured metadata.
