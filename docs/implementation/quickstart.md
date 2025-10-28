# How to publish Job Openings

There are 5 easy steps to revolutionize job publishing.

## 1. Website
You need **your own domain and website**: e.g. www.example.com.

There you publish your job openings as web page. This can be using a CMS, static site generator or plain HTML, as you like.

## 2. Create ojobpub.json
Create an [ojobpub.json](./ojobpub-format.md) in the path `/.well-known/ojobpub.json` (all lower case!) in a **specific JSON format containing structured meta information** about your job openings and link to the full job description on your website.

!!! tip "File or Application?"
    While we have used a static ojobpub.json file to demonstrate the simplest way to provide the data, this endpoint is not limited to a static file. It could just as easily be served by a dynamic application or script.

## 3. Validate

To validate the JSON data format, we provide a [LetsEmploy's oJobPub JSON schema](https://github.com/letsemploy/schema) and a validator app [validator.letsemploy.org](https://validator.letsemploy.org) to help validate the structure.

## 4. Let us know

Go to [jobs.letsemploy.org](https://jobs.letsemploy.org), enter your domain (fqdn) and **let us index your jobs**!

This helps us to see, how things are growing. Once this format is known and etablished, this step may become obsolete (hopefully!). Job crawlers can get all the domains from us for free using our API.

## 5. Spread the Word

Let others know you are publishing job openings using oJobPub by **adding a link** on your job site:

[![Supports LetsEmploy.org](https://img.shields.io/badge/supports-LetsEmploy.org-purple)](https://letsemploy.org){:target="_blank"}

```html
<a href="https://letsemploy.org" target="_blank">
  <img
    alt="Supports LetsEmploy.org"
    src="https://img.shields.io/badge/supports-LetsEmploy.org-purple"
    />
</a>
```
