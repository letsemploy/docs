# Publishing

This section explains how to publish job openings as an oJobPub feed on your own domain.

## Prerequisites

- **A registrable domain** under your control, e.g. `example.com`. The feed is discovered on the apex domain, not on a subdomain.
- **HTTPS** on that domain with a valid certificate.
- **A public web page per opening** with the full description and application instructions, e.g. `https://www.example.com/careers/product-manager`. It doesn't matter how the page is produced (CMS, static site generator, ATS, plain HTML), as long as it has a stable URL. The feed links to this page.

## Steps

1. [Create the feed](create.md): write or generate `ojobpub.json` and validate it against the schema.
2. [Serve the feed](serve.md): make it available at `https://<domain>/.well-known/ojobpub.json`.
3. [Register](register.md): add your domain to SourceTracker so the feed is indexed and distributed.
