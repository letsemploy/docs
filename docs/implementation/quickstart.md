# How to publish Job Openings

There are 5 easy steps to revolutionize job publishing.

## 1. Website
You need **your own domain and website**: e.g. www.example.com.

You publish your full description of your job openings in a web page. This can be using a CMS, static site generator or plain HTML, as you like and become accessible using a link, e.g. https://www.example.com/career/job-product-manager/.

## 2. Create ojobpub.json
Create an [ojobpub.json](./ojobpub-format.md) and save it under the path `example.com/.well-known/ojobpub.json` (all lower case!) in a **specific JSON format containing structured meta information** about your job openings and a link to the full job description on your website.

!!! tip "File or Application?"
    While we have used a static ojobpub.json file to demonstrate the simplest way to provide the data, this endpoint is not limited to a static file. It could just as easily be served by a dynamic application or script. An open source tool to help creating a ojobpub.json is currently in development.

## 3. Validate
To ensure your ojobpub.json's data is valid, we provide a [oJobPub JSON schema](https://github.com/letsemploy/schema) and a validator app [validator.letsemploy.org](https://validator.letsemploy.org).

## 4. Let us know

Go to [app.letsemploy.org](https://app.letsemploy.org), enter your domain (fqdn) and **let us index your jobs**!

This helps us to see, how things are growing. Once this format is known and etablished, this step may become obsolete (hopefully!). Job crawlers can get all the domains from us for free using our API.

## 5. Spread the Word

We would appreciate if you let others know, you publish your job openings using oJobPub by **adding a link** on your job site:

[![Supports LetsEmploy.org](https://img.shields.io/badge/supports-LetsEmploy.org-purple)](https://letsemploy.org){:target="_blank"}

```html
<a href="https://letsemploy.org" target="_blank">
  <img
    alt="Supports LetsEmploy.org"
    src="https://img.shields.io/badge/supports-LetsEmploy.org-purple"
    />
</a>
```
