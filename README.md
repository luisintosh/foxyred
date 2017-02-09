# README

### A URL link shortener, make short links and earn the biggest money.

## Environment variables

Configure the e-mail address 'no-reply@...'

    ENV['MAILER_SENDER']

Configure SMTP Mail server

    config.action_mailer.smtp_settings = {
	    address: ENV['SMTP_ADDRESS'],
	    port: ENV['SMTP_PORT'],
	    user_name: ENV['SMTP_USERNAME'],
	    password: ENV['SMTP_PASSWORD'],
	    authentication: :plain,
	    enable_starttls_auto: true
	  }


----------

**To do**

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
