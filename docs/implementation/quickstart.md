# How to publish Job Openings

There are 5 easy steps to revolutionize job publishing.

## 1. Website

You need **your own domain and website**: e.g. domain example.com.

You publish your full description of your job openings in a web page. This can be using a CMS, static site generator or plain HTML, as you like and become accessible using a link, e.g. https://www.example.com/career/job-product-manager.html.

## 2. Create ojobpub.json

Create an [ojobpub.json](./ojobpub-format.md) in a **specific JSON format containing structured meta information** about your job openings and a link to the full job description on your website.

!!! tip "File or Application?"
    While we have used a static ojobpub.json file to demonstrate the simplest way to provide the data, this endpoint is not limited to a static file. It could just as easily be served by a dynamic application or script.

To ensure your ojobpub.json's data is valid, we provide a [oJobPub JSON schema](https://github.com/letsemploy/schema) and a validator app [validator.letsemploy.org](https://validator.letsemploy.org) for manual validation.

## 3. Make ojobpub.json accessible on your website.

The data should be accessible to a specific path `https://example.com/.well-known/ojobpub.json` (without `www.` prefix!).

### 3.1 Local Path

Save the ojobpub.json under this path on your webserver so it is accessible under the domain `example.com` (without `www.` prefix!) `https://example.com/.well-known/ojobpub.json` (also see 3.2.1 Different vHost).

### 3.2 HTTP Redirect

Creating a redirect to a different domain, vHost or path.

##### 3.2.1 Different vHost

!!! tip "Redirect as Default"
    Many webservers are configured to redirect `example.com` to `www.example.com` while keeping the URI (path) per default.

If you have a website under https://www.example.com you can try what happens if you place the ojobpub.json in this `vhost` so it would be accessible like so `https://www.example.com/.well-known/ojobpub.json` then access the location `https://example.com/.well-known/ojobpub.json` and see if it worked.

```
$ curl -i https://example.com/.well-known/ojobpub.json
HTTP/2 302
location: https://www.example.com/.well-known/ojobpub.json
server: Caddy
content-length: 0
date: Wed, 24 Dec 2025 10:59:51 GMT

```

##### 3.2.2 Different Domain

You can redirect to another domain like `https://jobs.example.com/just-an example/ojobpub.json`

=== "Apache HTTPD"

    ```
    <VirtualHost *:443>
      ServerName www.example.com
      ServerAlias example.com

      Redirect "/.well-known/ojobpub.json" "https://jobs.example.com/just-an-example/ojobpub.json"
    </VirtualHost>
    ```

=== "Nginx"

    ```
    server {
      server_name example.com www.example.com;

      root /var/www/example.com/html;
      index index.html;

      location /.well-known/ojobpub.json {
        return 307 https://jobs.example.com/just-an-example/ojobpub.json;
      }

      location / {
        try_files $uri $uri/ =404;
      }
    }
    ```

=== "Caddy"

    ```
    example.com www.example.com {
      route /.well-known/ojobpub.json {
        redir https://jobs.example.com/just-an-example/ojobpub.json
      }
    }
    ```

### 3.3 Reverse Proxy

Reverse proxy to hide the final location from the public. If you have an application providing the data of ojobpub.json on the fly, we would recommend to use this option.

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
