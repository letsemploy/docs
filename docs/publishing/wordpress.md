# WordPress

The **oJobPub** plugin publishes the job openings of a WordPress site at `/.well-known/ojobpub.json`. Jobs can come from the plugin's own *Jobs* post type or from an existing job plugin:

| Source | Plugin | Notes |
|---|---|---|
| Built-in | – | Simple *Jobs* post type with all oJobPub fields. Also adds schema.org JobPosting for Google for Jobs. |
| WP Job Manager | [wp-job-manager](https://wordpress.org/plugins/wp-job-manager/) | Filled positions are left out. |
| Job Postings | [job-postings](https://wordpress.org/plugins/job-postings/) | Country names such as "Schweiz" are resolved to ISO codes. |

## Setup

1. Install and activate the plugin.
2. Go to **Settings → oJobPub**.
3. Check the employer details, the default language and the default country.
4. Choose the **data source**. A job plugin is only listed when it is active.
5. Click **Check feed**. The check fetches the feed the way a consumer does and reports redirects, wrong content types or stale copies.
6. [Register](register.md) your domain with SourceTracker.

Jobs that cannot be published, for example because they have no location, are listed on the settings screen with the reason. They do not break the rest of the feed. Jobs whose application deadline has passed are removed automatically.

!!! note "Hosts that answer `/.well-known/` themselves"
    Some hosts serve everything below `/.well-known/` directly from disk, because they use that path for SSL certificates, and never pass the request to WordPress. If **Check feed** reports the feed as not reachable, enable **Static file**. The plugin then also writes the feed as a file to that path. See also [Serve the Feed](serve.md).

## For job plugin authors

The plugin reads jobs through *sources*. If you maintain a job plugin, you can ship the source for your own data model, so the mapping stays with the people who know the data:

```php
add_filter( 'ojobpub_sources', function ( $sources ) {
	$sources[] = new My_Plugin_OJobPub_Source();
	return $sources;
} );
```

A source implements `OJobPub\Sources\Source`:

```php
final class My_Plugin_OJobPub_Source implements \OJobPub\Sources\Source {

	public function id() {
		return 'my-plugin'; // Stored in the settings; keep it stable.
	}

	public function label() {
		return __( 'My Plugin', 'my-plugin' );
	}

	public function is_available() {
		return class_exists( 'My_Plugin' );
	}

	public function post_types() {
		return array( 'my_job' ); // Changes to these posts rebuild the feed.
	}

	/**
	 * @param array $defaults Site defaults: language, country, jobType.
	 * @return iterable Raw jobs keyed by post ID, using the oJobPub field names.
	 */
	public function jobs( array $defaults ) {
		$jobs = array();
		foreach ( get_posts( array( 'post_type' => 'my_job', 'posts_per_page' => 500 ) ) as $post ) {
			$jobs[ $post->ID ] = array(
				'title'       => get_the_title( $post ),
				'language'    => $defaults['language'],
				'publishedAt' => get_post_time( 'Y-m-d', true, $post ),
				'jobType'     => $defaults['jobType'],
				'locations'   => array( array( 'city' => $post->my_city, 'country' => $defaults['country'] ) ),
				'url'         => get_permalink( $post ),
				'description' => $post->post_content,
			);
		}
		return $jobs;
	}
}
```

The raw jobs do not have to be perfect. The plugin normalizes them before publishing:

- It strips HTML and truncates `description` to 1000 characters.
- It parses amounts like `90'000` or `85k`.
- It removes duplicate tags and leaves out jobs whose `applyBefore` has passed.

Jobs that are still invalid are skipped and listed on the settings screen.

The plugin already ships sources for WP Job Manager (`wp-job-manager`) and Job Postings (`job-postings`). If your plugin registers a source **with the same id**, the one registered last wins, so your own adapter replaces the built-in one. Register on the default priority, or later.

Further filters:

| Filter | Purpose |
|---|---|
| `ojobpub_raw_jobs` | Adjust the raw jobs of the active source before normalization. |
| `ojobpub_employer` | Adjust the employer before normalization. |
| `ojobpub_document` | Adjust the final document. It must stay valid against the schema. |
| `ojobpub_wp_job_manager_job`, `ojobpub_job_postings_job` | Adjust the mapping of one job in the built-in adapters. |
| `ojobpub_max_jobs` | Maximum number of jobs read per source (default 500). |
