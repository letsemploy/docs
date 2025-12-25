# About oJobPub

oJobPub is the heart of our standard, our minimalistic data file in JSON ([Wikipedia](https://en.wikipedia.org/wiki/JSON)), containing meta infos about your job openings.
It must be made accessible on a defined path in your web hosting, a so called _well-known path_ ([Wikipedia](https://en.wikipedia.org/wiki/Well-known_URI)).

Example:

**`<yourdomain.tld>/.well-known/ojobpub.json`**

## Structure / Format

The structure of the [format](./format.md) is defined in a [JSON Schema](./schema.md) ([json-schema.org](https://json-schema.org/understanding-json-schema/about))

- Raw schema is located at [gh/letsemploy/schema](https://github.com/letsemploy/schema).
- Online schema validation [validator.letsemploy.org](https://validator.letsemploy.org)
