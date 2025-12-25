## How to find all domains that using ojobpub?

We will provide a free download service to get all the domains publishing vacancies as ojobpub.json.

## How to search for jobs published by ojobpub atm?

We are currently working on free web service which allows to create an initial index of published jobs with statistics. This service will provide also a free service to search for vacancies.

## I have an idea and want to start a discussion, where should I place it?

We use [GitHub discussions](https://github.com/letsemploy/docs/discussions) for ideas. feature requests and general discussions.

## Where to place e-mail address in ojobpub.json for candidates to apply?

We don't recommend to add anything about job application into ojobpub.json. Because these meta data will be crawled and distributed.

We recommend to add instructions for the application process on your website in the job details page instead which linked by the `url` in ojobpub.json.

## We don't have any vacancies atm, should we add a ojobpub.json?

Yes! Any company should add a ojobpub.json on their website, even without any vacancies.

## Does it cost anything?

Beside what you already pay for a domain and web hosting, there are no additional costs!

## Why a new format?

There are already existing formats for job ads, the most promising of which [job-posting JSON Schema](https://schema.org/JobPosting) seems also be supported by Google [^1].

However, a bot must crawl the entire website to find the job ads and it is bloated with data. For us, this format seems to be most useful for larger search bots such as Google. oJobPub does not restrict you from using this format on your job description website as well; it complements it.

There is also another schema: [*json-job*](http://lukasz-madon.github.io/json-job/). It is somewhat more comprehensive and the project has not been active for over 10 years. It does not define where this data should be placed on your website. We could have used it, but we didn't want to wake sleeping daemons.

[^1]: [Google documentation about job-posting](https://developers.google.com/search/docs/appearance/structured-data/job-posting?hl=en)
