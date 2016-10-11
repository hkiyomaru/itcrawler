# IMAGE & TEXT CRAWLER

## Getting Started

All the scripts in this repository are written in __Ruby 2.3.1__.

You have to install some dependent packages.

```
$ bundle install --path vendor/bundle
```

## Twitter API

In addition, it is necessary to set keys and access token to use Twitter API.

[Twitter apps](https://apps.twitter.com/)

Create your app and get them.

Then, edit the configuration file.

```
$ cd config
$ cp cp twitter_api_config.json.example twitter_api_config.json
```

## Run

```
$ cd source
$ bundle exec ruby itcrawler.rb
```
