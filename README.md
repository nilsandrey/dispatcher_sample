# README

> **Problem background and design assumptions are described in [the wiki](https://github.com/nilsandrey/dispatcher_sample/wiki).**

> **See the api-docs on deployment of the API by browsing to the endpoint/doc, like in <http://localhost:3000/doc>.**

## Architecture

* Ruby on Rails application running the API. Include a background job service.
* Database in MySQL with persisten data.
* Proposed deployment configuration using Docker.

## Configuration

* Create/modify [.env files ↗](https://docs.docker.com/compose/env-file/) for configuring the different services that will run in containers following this steps: 
  
  * Create a [`db.env`](https://github.com/nilsandrey/dispatcher_sample/blob/main/db.env) file in the root directory with the variables used to build the data base container.
  
  * Create a [`web.env`](https://github.com/nilsandrey/dispatcher_sample/blob/main/web.env) file in the root directory with the variables used to build the web api container.

> ***NOTICE:** .env files shouldn't be included in a real producciton ready repo. If included is just for simplifying the demo setup.* 

## Setup

This is a simple Docker setup for use in developing the API. It includes the services you need to run the API, including a database.

1. Install Docker

2. Create a Docker network
   `docker network create musalasoft-drones`

3. Build the containers

```bash
docker-compose build --build-arg RAILS_ENV=development
```

3. Start the containers in [detached mode ↗](https://docs.docker.com/compose/reference/up/)

```bash
`docker-compose up -d`
```

> If you want to stop the containers run `docker-compose down`

## Database creation

* `docker-compose run web rails db:create` Create the database.
* `docker-compose run web rails db:seed` Load initial data.

## How to run the test suite

`docker-compose run web rails`

## Using the API

Instructions describing  all the API methods and its parameters are defined in [public/doc](https://github.com/nilsandrey/dispatcher_sample/tree/main/public/doc) and can be browsed upon deployment in the url `/doc`.

![](https://github.com/nilsandrey/dispatcher_sample/wiki/images/api-docs-sample.png)
