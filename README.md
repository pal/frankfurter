# Frankfurter

[![Build](https://github.com/hakanensari/frankfurter/workflows/build/badge.svg)](https://github.com/hakanensari/frankfurter/actions)

[Frankfurter](https://www.frankfurter.app) is a free and open-source currency data API that tracks reference exchange rates published by the European Central Bank.

`api.frankfurter.app` hosts a public instance of the API.

## Getting Started

Get the latest exchange rates.

```
https://api.frankfurter.app/latest
```

Get rates for a past date.

```
https://api.frankfurter.app/2000-01-03
```

Get rates for a period.

```http
https://api.frankfurter.app/2010-01-01..2010-01-31
```

For more examples, read the [docs](https://www.frankfurter.app/docs).

## Configuring your own instance

You need to enter your own API keys and username/passwords for the following files:
```bash
cp config/newrelic.yml.example config/newrelic.yml
cp .env.example .env
cp telegraf.conf.example telegraf.conf
```

## Deployment

You can self-host Frankfurter with Docker.

### Using Docker

```bash
docker build -t frankfurter .

docker run -d -p 3000:3000 \
  -e "SQLITE_DB=frankfurtdb.db" \
  -e PORT=3000 \
  --name frankfurter \
  -it frankfurter
```

Check out http://localhost:3000/latest

### Push to Docker Hub

In order to make deployment super-simple, we can push a version to [Docker Hub](https://hub.docker.com/repository/docker/palbrattberg/frankfurter), I simply push to `palbrattberg/frankfurter`.

To push your own, first create a new repository on Docker Hub, then build and push your image:

```bash
docker login
docker buildx create --use desktop-linux
docker buildx build --push --platform linux/arm/v7,linux/arm64,linux/amd64 -t palbrattberg/frankfurter:latest .
```

## Load testing
We use [k6](https://k6.io) for load testing the API. 

For local runs, just install k6 and go for it:
```bash
brew install k6
k6 run spec/load_test/stress.js
```

If you want nice visualization, you might want to push the output to Grafana. Be sure to update your local copy of `telegraf.conf` with good values for username, password and url, see [k6 with Grafana Cloud](https://k6.io/docs/results-visualization/grafana-cloud/).

```bash
brew install k6 telegraf 
ulimit -n 10240 # increase the number of open files allowed
telegraf -config /usr/local/etc/telegraf.conf
k6 run --out influxdb=http://localhost:8186 spec/load_test/stress.js
```

Now you should be able to see some stats in Grafana Cloud.

## Running tests

```bash 
# must have .env file present
cp .env.example .env # only run this one time

bundle exec rake
```

## Miscellaneous

In this fork there is no rounding of the rates in order to support better precision for downstream applications.

This fork uses sqlite instead of PostgreSQL.
