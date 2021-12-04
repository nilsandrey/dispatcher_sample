# README

> Still working in progress....

Things you may want to cover:

* Architecture

* System dependencies
  - Docker

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Architecture

* Ruby on Rails application running the API. Include a background job service.
* Database in MySQL with persisten data.
* Proposed deployment configuration using Docker.

## Configuration

* Create .env files for configuring the different services that will run in containers following this steps: (format is ...) TODO: Refence required
  * Create a `db.env` file in the root directory. 
  
  * Configure variables according to ...  TODO: Refence required to the wiki for db.env
  
  * Create a `web.env` file in the root directory. 
  
  * Configure variables according to ...  TODO: Refence required to the wiki for db.env
  
> ***NOTICE:** .env files shouldn't be included in the repo. If included is just for simplifying the demo setup.* 

## Setup

This is a simple Docker setup for use in developing the API. It includes the services you need to run the API, including a database.

1. Install Docker

2. Create a Docker network
`docker network create musalasoft-drones`

3. Build the containers

```bash
docker-compose build --build-arg RAILS_ENV=development
```

3. Start the containers in [detached mode](https://docs.docker.com/compose/reference/up/)

```bash
`docker-compose up -d`
```

> If you want to stop the containers run `docker-compose down`

## Database creation

* `docker-compose run web rails db:create` Create the database.
* `docker-compose run web rails db:seed` Load initial data.



...