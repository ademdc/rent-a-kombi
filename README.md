# README

This is a Rails 5 application for renting vehicles.

## CONFIGURATION

### Requirements
* Ruby 2.4.9
* ImageMagick
* Redis

### Deployment

`git push heroku master`

### Database

Dump and download PG backup database to local machine

`heroku pg:backups:capture`

`heroku pg:backups:download`

Restore database

`pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d rentakombi_development latest.dump`


### Redis

In order to run the application succesfully install redis on local machine and run it

`brew install redis`

`redis-server`


### Starting the server
- First we are going to install all gems with ```bundle install```
- Then we are going to update database schema by running the migrations. To do so, run ```bundle exec rails db:create db:migrate```
- And then precompile them with ```bundle exec rake assets:precompile```
- Start the server with ```rails s```
- Start redis with ```redis-server```



  
