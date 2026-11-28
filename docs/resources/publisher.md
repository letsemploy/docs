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
- **Domains**: each of your domains gets a permalink, the one public URL. Publisher writes the webserver configuration and checks your setup.
- **Click counting**: job links in a feed go through Publisher, which counts clicks per job and day and redirects to the job page. No visitor address is stored. Can be switched off when self-hosting.
- **Team access**: owners and editors, with an activity log.
- **GraphQL API** at `/graphql` for integrations, authenticated with service tokens.
- **Sign-in** via OpenID Connect (Google, GitLab, Microsoft, Keycloak, …) or GitHub, optionally also with email and password.
- **User manual** at `/docs`, in every language of the application.

## Connect a feed to your domain

Under **Domains**, each domain has a permalink: a public URL that stays the same while you switch the feed behind it.

```
https://publisher.letsemploy.org/ojobpub/v1/permalink/<id>/ojobpub.json
```

Every employer starts with one permalink publishing its `all` feed. After signing in, Publisher asks for its domain, the apex domain such as `example.com`. Each domain can be used once per employer.

Point your well-known path to the permalink with a [redirect or reverse proxy](../publishing/serve.md). The domain's page has ready-made configurations for Apache, Nginx and Caddy, e.g. for Nginx:

```nginx
location = /.well-known/ojobpub.json {
  return 302 https://publisher.letsemploy.org/ojobpub/v1/permalink/<id>/ojobpub.json;
}
```

**Check setup** then fetches the address on your website and tells you whether it serves the permalink, and what to fix if not. Then [register](../publishing/register.md) your domain with SourceTracker.

!!! warning "Feed URLs are no longer public"
    Since Publisher 2.0, a feed's own URL (`/ojobpub/v1/<employer>_<id>/<feed>_<id>/ojobpub.json`) answers only signed-in members of the employer. Everyone else gets `404`. If you pointed a website or job board at a feed URL, switch it to a permalink.

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

- Permalink URLs are built from `APP_BASE_URL`, so set it to the public address, especially behind a reverse proxy.
- The health endpoint is `/actuator/health`.
- Configuration files, MariaDB, multiple identity providers and a Kubernetes example are covered in the [repository README](https://github.com/letsemploy/publisher#run-it).
