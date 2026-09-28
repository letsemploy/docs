# Publisher

| | |
| --- | --- |
| Website | [publisher.letsemploy.org](https://publisher.letsemploy.org) |
| Source | [github.com/letsemploy/publisher](https://github.com/letsemploy/publisher), Apache 2.0 |
| Container | `ghcr.io/letsemploy/publisher` (`amd64`, `arm64`) |
| Status | Released |

Publisher manages an employer's job openings and serves them as oJobPub feeds. You don't have to write JSON by hand. Use the hosted instance at [publisher.letsemploy.org](https://publisher.letsemploy.org), or run it yourself.

## Features

- **Jobs** with locations, tags, salary and an application window. A job is published only while it is active, complete and within its dates.
- **Feeds** with a selectable set of jobs and schema validation. An employer can have several feeds, e.g. one per job board.
- **Team access**: owners and editors, with an activity log.
- **GraphQL API** at `/graphql` for integrations, authenticated with service tokens.
- **Sign-in** via OpenID Connect (Google, GitLab, Microsoft, Keycloak, …) or GitHub. No passwords are stored.

## Connect a feed to your domain

Each feed has a stable public URL:

```
https://publisher.letsemploy.org/ojobpub/v1/<employer>_<id>/<feed>_<id>/ojobpub.json
```

Point your well-known path to it with a [redirect or reverse proxy](../publishing/serve.md), e.g. in Nginx:

```nginx
location = /.well-known/ojobpub.json {
  return 302 https://publisher.letsemploy.org/ojobpub/v1/acme_1a2b/main_3c4d/ojobpub.json;
}
```

Then [register](../publishing/register.md) your domain with SourceTracker.

## Self-hosting

The container image runs in 512 MB of memory and supports SQLite (single instance) or MariaDB. The minimal setup uses SQLite and an OpenID Connect provider:

```sh
docker run -d --name publisher -p 8080:8080 -v publisher-data:/data \
  -e SPRING_PROFILES_ACTIVE=sqlite \
  -e APP_SQLITE_PATH=/data/ojobpub.db \
  -e APP_BASE_URL=https://jobs.example.com \
  -e SPRING_SECURITY_OAUTH2_CLIENT_PROVIDER_OIDC_ISSUER_URI=https://login.example.com/realms/example \
  -e SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_OIDC_CLIENT_ID=ojobpub-publisher \
  -e SPRING_SECURITY_OAUTH2_CLIENT_REGISTRATION_OIDC_CLIENT_SECRET=change-me \
  ghcr.io/letsemploy/publisher:latest
```

- Feed URLs are built from `APP_BASE_URL`, so set it to the public address, especially behind a reverse proxy.
- The health endpoint is `/actuator/health`.
- Configuration files, MariaDB, multiple identity providers and a Kubernetes example are covered in the [repository README](https://github.com/letsemploy/publisher#run-it).
