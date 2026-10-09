# Validator

| | |
| --- | --- |
| Website | [validator.letsemploy.org](https://validator.letsemploy.org) |
| API | [REST](#rest-api), [Swagger UI](https://validator.letsemploy.org/docs) |
| Source | [github.com/letsemploy/validator](https://github.com/letsemploy/validator) |
| Container | `ghcr.io/letsemploy/validator` (`amd64`, `arm64`) |
| Status | Stable, best effort |

The Validator checks an oJobPub document against the [oJobPub JSON Schema](https://github.com/letsemploy/schema) (draft 2020-12), including the `date`, `date-time` and `uri` formats. It checks the schema only. It doesn't check that `lastUpdated` is current, that every `url` resolves, or the [description policy](sourcetracker.md#probes) that SourceTracker applies.

## Web UI

Paste a document into the editor at [validator.letsemploy.org](https://validator.letsemploy.org) and press **Validate** (or Ctrl/⌘ + Enter). **Load example** fills in a valid document, **Format** pretty-prints your input. Each violation is listed with its JSON path, e.g. `$.jobs[0].url`. JSON syntax errors show the line and column.

## REST API

```sh
curl -s https://validator.letsemploy.org/api/v1/validate \
  -H 'Content-Type: application/json' \
  --data @ojobpub.json
```

```json
{"valid": false, "errors": [{"message": "'title' is a required property", "path": "$.jobs[0]"}]}
```

| Status | Meaning |
| --- | --- |
| `200` | Validation ran. Check `valid` |
| `400` | The body is not valid JSON (`errors` holds line and column) |
| `413` | The body exceeds the size limit (1 MiB by default) |
| `415` | `Content-Type` is not `application/json` |
| `503` | The schema could not be loaded |

The OpenAPI spec is at [`/api/v1/openapi.json`](https://validator.letsemploy.org/api/v1/openapi.json).

## Offline validation

Any JSON Schema draft 2020-12 validator works, e.g. in CI:

```sh
check-jsonschema \
  --schemafile https://raw.githubusercontent.com/letsemploy/schema/main/v1/ojobpub.json \
  public/.well-known/ojobpub.json
```

The schema validates structure only. Also make sure `lastUpdated` is current and every `url` resolves.

## Self-hosting

```sh
docker run -d --name validator -p 8000:8000 ghcr.io/letsemploy/validator:main
```

| Variable | Default | Purpose |
| --- | --- | --- |
| `SCHEMA_URL` | oJobPub v1 schema on GitHub | Schema to validate against |
| `SCHEMA_CACHE_TTL` | `300` | Seconds to cache the schema |
| `MAX_CONTENT_LENGTH` | `1048576` | Maximum request size in bytes |
