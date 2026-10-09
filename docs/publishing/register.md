# Register

Publishing the feed doesn't notify anyone. Register your domain with [SourceTracker](../resources/sourcetracker.md) so it's validated daily and included in the public export.

## Add your domain

Submit the **apex domain** (e.g. `example.com`, not `www.example.com`) at [sources.letsemploy.org/sources/new](https://sources.letsemploy.org/sources/new).

## What happens next

1. Your domain is accepted as a `PENDING` candidate, and SourceTracker probes it right away. Candidates aren't listed publicly yet.
2. The first probe that passes every check admits the domain to the register as `HEALTHY`. A failing candidate is retried every hour and deleted if it isn't admitted within **24 h**. Fix the feed and register it again.
3. Once registered, healthy sources are probed every **24 h**, unhealthy ones every **1 h**. The source page shows each check's result and details. You can request an earlier revisit there after you fix an issue.
4. Feeds of healthy sources are included in the next [daily export](../consuming/index.md#daily-export).

After 10 failed probes in a row, a source is `SUSPENDED`: it stays listed, is probed weekly and is reinstated automatically once a probe passes. Sources suspended for more than 180 days are removed. See the [lifecycle](../resources/sourcetracker.md#lifecycle) for details.

## Badges (optional)

To show the live status of your feed, embed the SourceTracker status badge. Replace `example.com` with your domain:

```html
<img src="https://sources.letsemploy.org/api/sources/example.com/badge.svg" alt="oJobPub status">
```

The same status is available as JSON at `https://sources.letsemploy.org/api/sources/example.com`.

To show that your job page supports oJobPub, add this badge:

[![Supports LetsEmploy.org](https://img.shields.io/badge/supports-LetsEmploy.org-purple)](https://letsemploy.org){:target="_blank"}

```html
<a href="https://letsemploy.org" target="_blank">
  <img alt="Supports LetsEmploy.org" src="https://img.shields.io/badge/supports-LetsEmploy.org-purple">
</a>
```
