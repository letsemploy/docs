# Serve the Feed

The feed must be reachable over HTTPS at the well-known path on the **apex domain**:

```
https://example.com/.well-known/ojobpub.json
```

Redirects are allowed, including to another host or path, as long as the final response is the JSON document. Consumers (SourceTracker) follow at most **5** redirects.

There are three ways to serve the feed:

- [Static file](#static-file): the file sits in the web root.
- [Redirect](#redirect): the apex URL redirects to where the file is hosted.
- [Reverse proxy](#reverse-proxy): the web server proxies the path to an application or bucket.

## Static file

Place the file in `.well-known/` below the web root, e.g.:

```
/var/www/example.com/.well-known/ojobpub.json
```

Many setups redirect `example.com` to `www.example.com` and keep the path. In that case, placing the file in the `www` vhost is enough:

```console
$ curl -sI https://example.com/.well-known/ojobpub.json
HTTP/2 301
location: https://www.example.com/.well-known/ojobpub.json
```

!!! warning
    A redirect to the homepage (`location: https://www.example.com/`) is not valid. The target must be the feed itself.

## Redirect

Redirect the well-known path to wherever the feed is hosted:

=== "Nginx"

    ```nginx
    server {
      server_name example.com www.example.com;

      location = /.well-known/ojobpub.json {
        return 302 https://jobs.example.com/feeds/ojobpub.json;
      }
    }
    ```

=== "Apache HTTPD"

    ```apache
    <VirtualHost *:443>
      ServerName example.com
      ServerAlias www.example.com

      Redirect 302 "/.well-known/ojobpub.json" "https://jobs.example.com/feeds/ojobpub.json"
    </VirtualHost>
    ```

=== "Caddy"

    ```caddy
    example.com, www.example.com {
      redir /.well-known/ojobpub.json https://jobs.example.com/feeds/ojobpub.json 302
    }
    ```

Use a temporary redirect (`302`/`307`) if the target may change.

## Reverse proxy

A reverse proxy keeps the public URL stable and hides the origin. Use it when an application generates the feed, or when the file lives in object storage.

=== "Application"

    ```nginx
    location = /.well-known/ojobpub.json {
      proxy_pass http://127.0.0.1:8080/api/ojobpub.json;
    }
    ```

=== "S3 bucket"

    ```nginx
    location = /.well-known/ojobpub.json {
      proxy_pass https://my-bucket.s3.eu-central-1.amazonaws.com/ojobpub.json;
      proxy_set_header Host my-bucket.s3.eu-central-1.amazonaws.com;
    }
    ```

## Response headers

| Header | Value | |
| --- | --- | --- |
| `Content-Type` | `application/json` | recommended |
| `Access-Control-Allow-Origin` | `*` | optional, allows browser-based consumers |

## Verify

```sh
curl -sSL -D- https://example.com/.well-known/ojobpub.json -o /dev/null   # status, redirects, headers
curl -sSL https://example.com/.well-known/ojobpub.json | python3 -m json.tool  # valid JSON
```

Then [validate](create.md#validate) the downloaded document against the schema.
