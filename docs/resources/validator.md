# Validator

| | |
| --- | --- |
| Website | [validator.letsemploy.org](https://validator.letsemploy.org) |
| Status | Stable, best effort |

The Validator checks an oJobPub document against the oJobPub JSON Schema.

## Offline validation

Any JSON Schema draft 2020-12 validator works, e.g. in CI:

```sh
check-jsonschema \
  --schemafile https://raw.githubusercontent.com/letsemploy/schema/main/v1/ojobpub.json \
  public/.well-known/ojobpub.json
```

The schema validates structure only. Also make sure `lastUpdated` is current and every `url` resolves.
