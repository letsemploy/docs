# How to publish Job Openings

There are 5 easy steps to optimize job publishing.

## 1. Website
You need **your own website**: e.g. www.example.com, on which you publish your job openings as usual. This can be a [Wordpress](https://wordpress.org/), another CMS, plain HTML or any other way.

## 2. Create an ojobpub.json
Create a file `/.well-known/ojobpub.json` (all lower case!) in a **specific JSON format containing structured meta information** about your job openings and link to the full job description on your website.

!!! tip "File or Application?"
    While we have used a static ojobpub.json file to demonstrate the simplest way to provide the data, this endpoint is not limited to a static file. It could just as easily be served by a dynamic application or script.

## 3. Validate

To validate the JSON data format, we provide a [oJobPub JSON schema](https://github.com/ojobpub/schema) and an app [validator.ojobpub.org](https://validator.ojobpub.org) to help validate the data file.

## 4. Let's index

Go to [index.ojobpub.org](https://index.ojobpub.org), enter your domain (fqdn) and **let us index your jobs**! 

This helps us to see, how things are growing. Once this format is known and etablished, this step may become obsolete (hopefully!). Job crawlers can get all the domains from us for free using an API.

## 5. Spread the Word

Let others know you are publishing job openings using oJobPub by **adding a link** on your job site:
```html
<a href="https://ojobpub.org">Supports oJobPub.org</a>
```
