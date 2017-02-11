# README

### A URL link shortener, make short links and earn the biggest money.

## Environment variables

Configure the e-mail address 'no-reply@...'

    ENV['MAILER_SENDER']


Sample SMTP Mail settings

	config.action_mailer.smtp_settings = {
	address:              'smtp.gmail.com',
	port:                 587,
	domain:               'example.com',
	user_name:            '<username>',
	password:             '<password>',
	authentication:       'plain',
	enable_starttls_auto: true  }


Configure SMTP Mail settings

	config.action_mailer.smtp_settings = {
		address: ENV['SMTP_ADDRESS'],
		port: ENV['SMTP_PORT'],
		domain: ENV['SMTP_DOMAIN']
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
