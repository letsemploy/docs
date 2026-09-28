# Register

Publishing the feed doesn't notify anyone. Register your domain with [SourceTracker](../resources/sourcetracker.md) so it's validated daily and included in the public export.

## Add your domain

Submit the **apex domain** (e.g. `example.com`, not `www.example.com`) at [sources.letsemploy.org/sources/new](https://sources.letsemploy.org/sources/new).

## What happens next

1. SourceTracker runs a first probe right away. The source status is `UNKNOWN` until the probe finishes.
2. The status becomes `HEALTHY` if all checks pass, otherwise `UNHEALTHY`. The source page shows each check's result and details.
3. Healthy sources are probed every **24 h**, unhealthy ones every **1 h**. You can request an earlier revisit on the source page after you fix an issue.
4. Feeds of healthy sources are included in the next [daily export](../consuming/index.md#daily-export).

Sources that stay unhealthy for a long time are removed. You can register them again at any time.

## Badge (optional)

To show that your job page supports oJobPub, add this badge:

[![Supports LetsEmploy.org](https://img.shields.io/badge/supports-LetsEmploy.org-purple)](https://letsemploy.org){:target="_blank"}

```html
<a href="https://letsemploy.org" target="_blank">
  <img alt="Supports LetsEmploy.org" src="https://img.shields.io/badge/supports-LetsEmploy.org-purple">
</a>
```
