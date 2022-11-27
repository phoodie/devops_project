FROM ruby:alpine
MAINTAINER phoodie <email.com>

# Install packages in alphine linux
RUN apk add build-base ruby-nokogiri

# Installing ruby gems (packages)
RUN gem install rspec capybara selenium-webdriver

# Defining how a docker container should start
ENTRYPOINT [ "rspec" ]
