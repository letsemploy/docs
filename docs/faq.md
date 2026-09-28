# FAQ

## Where do I put an application e-mail address?

Not in the feed. The feed is crawled and redistributed, so contact data in it ends up in third-party indexes. Put application instructions on the job page referenced by `url`. That's also why the schema has no field for them.

## We have no open positions. Should we still publish a feed?

Yes. Publish `"jobs": []`. The domain stays healthy in SourceTracker, and consumers can tell "no openings" apart from "no feed".

## Can a job `url` point to a different domain, e.g. our ATS?

Yes. The `url` may be on any domain, e.g. `https://acme.jobs.example-ats.com/123`. Only the feed itself must be discoverable on your domain.

## We have several brands or subsidiaries on different domains.

Publish one feed per domain. Each feed describes the employer behind that domain.

## Can I add custom fields?

No. `additionalProperties` is `false` for the feed, `employer` and `job`, so unknown fields fail validation. Propose new fields in [GitHub Discussions](https://github.com/letsemploy/docs/discussions).

## How is this different from schema.org JobPosting?

JobPosting is markup embedded in a single job page. To find it, a crawler has to visit every page of the site. oJobPub lists all openings in one document at a fixed URL and links to those pages. Use both. See [Relation to other formats](ojobpub/index.md#relation-to-other-formats).

The older [json-job](http://lukasz-madon.github.io/json-job/) schema has been inactive for more than ten years and doesn't define a discovery location.

## How do I get a list of all publishing domains?

Download the [daily export](consuming/index.md#daily-export), or query sources via the [GraphQL API](consuming/index.md#graphql-api).

## Where can I propose changes or report issues?

Use [GitHub Discussions](https://github.com/letsemploy/docs/discussions) for ideas and questions, and the [schema repository](https://github.com/letsemploy/schema) for schema issues.
