# How to publish Job Openings

## 1. Website
You need **your own website**: e.g. www.example.com, on which you publish your job openings as usual. This can be a [Wordpress](https://wordpress.org/), another CMS, plain HTML or any other way.

## 2. Create a ojobpub.json
Create file `/.well-known/ojobpub.json` (all lower case!) in a **specific JSON format containing structured meta information** about your job openings and link to the full job description on your website.

## 3. Validate

To validate the JSON data format, we provide a [oJobPub JSON schema](https://github.com/ojobpub/schema) and an app [validator.ojobpub.org](https://validator.ojobpub.org) to help validate the data file.

## 4. Let's index

Go to [search.ojobpub.org](https://search.ojobpub.org), enter your domain and **let us index your jobs**! 

This helps us to see, how things are growing. Once this format is known and etablished, this step may become obsolete (hopefully!).

## 5. Spread the Word

<<<<<<< Updated upstream
Let others know you are publishing job openings using oJobPub by **adding a link** on your job site:
=======
Let others know you are publishing job openings using oJobPub by adding a link on your job site:

>>>>>>> Stashed changes
```html
<a href="https://ojobpub.org">Supports oJobPub.org</a>
```
