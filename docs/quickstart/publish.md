
# Publish ojobpub.json

ojobpub's data must be make accessible to a specific path `https://example.com/.well-known/ojobpub.json` (without `www.` prefix!, but read further about HTTP redirects)

There are a few ways to make ojobpub.json accessible:

- Local Path: Store it in your website root
- HTTP Redirect
- HTTP Reverse Proxy

## Local Path

Save the ojobpub.json on your webserver's root path by creating a directory `.well-known/` (not the dot prefix).

The root path of your website might look like something like `/var/www/example.com/`, so the file _ojobpub.json_ would be placed in `/var/www/example.com/.well-known/ojobpub.json`.

## HTTP Redirects

Creating a redirect to a different domain, vHost or path.

### Different vHost

If you have a website under https://www.example.com you can try what happens if you place the ojobpub.json in this `vhost` so it would be accessible like so `https://www.example.com/.well-known/ojobpub.json`.

Then access the location `https://example.com/.well-known/ojobpub.json` and see if it worked. Why? Many webservers are configured to redirect `example.com` to `www.example.com` while keeping the URI (path) per default.

```
$ curl -i https://example.com/.well-known/ojobpub.json
HTTP/2 302
location: https://www.example.com/.well-known/ojobpub.json
server: Caddy
content-length: 0
date: Wed, 24 Dec 2025 10:59:51 GMT

```

### Different Domain

You can redirect to another domain like `https://jobs.example.com/just-an example/ojobpub.json`.

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

## Reverse Proxy

Reverse proxy is great to hide the final location from the public.

If you have an application providing the data of ojobpub.json on the fly, we would recommend to use this option.

Another sample would be to place ojobpub.json to an object storage (e.g. AWS S3) so a reverse proxy would access this bucket and serve the ojobpub.json.
