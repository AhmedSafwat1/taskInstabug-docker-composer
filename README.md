# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# TaskInstabug
  try to using docker-composer but have conflict with elasticsearch because the port 9200 conflict with other and when connect with it in rails give error but all run so if the probleam apperance can use  next step instead it
  * run docker-compose build
  * run docker-compose up
# First 
* must have docker if not have install it from https://www.docker.com/
* run the next line to install the  elasticsearch in you machine
* docker run --rm -d -e "discovery.type=single-node" \
    -e "bootstrap.memory_lock=true" \
    -p 9200:9200 \
    elasticsearch:6.8.1

# bundle install to install gem new
* run rake db:create when docker uisng docker-compose run web rake db:create  

# second 
* can import the link in postman an testing the api cal 

* https://www.getpostman.com/collections/fb82fe5ca8fd26808743

# routes 
   * post http://localhost:3000/v1/applications   to crate new application => return key whic will use need name as parmater
   * get  http://localhost:3000/v1/applications   to get all applications in sysem and number of chat in each one
   * get  http://localhost:3000/v1/applications/{key} to get the application which have the key  and number of chat
   * delete  http://localhost:3000/v1/applications/{key} to delate application and chats in and message
   * post http://localhost:3000/v1/applications/{key}/chats to create new chat and return number for it
   * get  http://localhost:3000/v1/applications/{key}/chats/{number} to get the the chat which have number return messages in
   * post  http://localhost:3000/v1/applications/{key}/chats/{number}/messages to create new message need to message as parmater 
   * get http://localhost:3000/v1/applications/{key}/chats/{number}/search  to search in message in this chat 
   *
