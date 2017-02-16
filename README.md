## Set up on Digital Ocean

![enter image description here](http://i.imgur.com/jQ6ROcN.jpg)

* Create a Droplet
* Navigate to 'One-click Apps' tab and click in Dokku's option
* Choose a size (at least 1GB of memory system)
* Add ssh keys
* Create the droplet

## Configure the droplet

Before create the Dokku application we have to configure some things on our system.

### Connect to your droplet
Open a Terminal and connect to your droplet as follow:

	$ ssh root@your-droplet-ip

### Add your ssh keys to Dokku user
Make sure that you add your ssh keys to Dokku user because it will be used when you deploy your app.
Don't do manually, run the following command:

	$ cat /root/.ssh/authorized_keys | sshcommand acl-add dokku dokku

### Add a Swap File
As we adviced before, it's time to add a swap file to our droplet to not run into memory problems.
The easy way to create it, run this command to execute a gist script:

	$ curl https://gist.githubusercontent.com/luisintosh/6accd2dbaee4e3ecb1dcd4a8115dbad2/raw/7472b9384e0acd0743a06042e85829c855abfdd1/create-swapfile-ondigital-ocean.sh  | sudo bash

It will create a 2GB Swap File for you!

## Create an application in Dokku

To create a Dokku application run the following command:

	$ dokku apps:create foxyred

### Create and Configure the database
You need to install a plugin to connect to the database. In this case we are going to use Postgres so, run:

	$ dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres

After install the plugin you can create the database for your application.

	$ dokku postgres:create foxyreddb

Link the database to your app

	$ dokku postgres:link foxyreddb foxyred

Running the following command you can see a list of environment vars for your application:

	$ dokku config foxyred

Reference: [https://github.com/dokku/dokku-postgres](https://github.com/dokku/dokku-postgres)

### Set your environment variables

Typically an application will require some configuration to run properly. Dokku supports application configuration via environment variables. Environment variables may contain private data, such as passwords or API keys, so it is not recommended to store them in your application's repository.

The **config** plugin provides the following commands to manage your variables:

    config (<app>|--global)                                   Display all global or app-specific config vars
    config:get (<app>|--global) KEY                           Display a global or app-specific config value
    config:set (<app>|--global) KEY1=VALUE1 [KEY2=VALUE2 ...] Set one or more config vars
    config:unset (<app>|--global) KEY1 [KEY2 ...]             Unset one or more config vars

Reference: [http://dokku.viewdocs.io/dokku/configuration/environment-variables/](http://dokku.viewdocs.io/dokku/configuration/environment-variables/)

#### Environment variables that must be setted

    dokku config:set foxyred MAILER_SENDER='no-reply@foxy.red' DOKKU_DOMAIN='foxy.red' SMTP_ADDRESS='smtp.mailgun.org' SMTP_USERNAME='no-reply@foxy.red' SMTP_PASSWORD='xxxxxxxxxxxxxx'

## Deploy the application

At this point, go to my github and get the code of the sample application:

	$ git clone https://bitbucket.org/luisintosh/foxyred

### Configuration files
You have to take in consideration the following files because they will make possible deploying the Dokku application.
If you are following this post and want to deploy my sample application, the changes are made yet so you have to do nothing but you will need to do it when you want to deploy your own application:

#### config/database.yml
To connect to Postgres we need to add the environment variable that Dokku set before for us.

		production:
            adapter: postgresql
            encoding: unicode
            pool: 5
            url: <%= ENV['POSTGRESQL_URL'] %>

#### config/puma.yml
Configuration file for Puma, a very fast and concurrent server that it's a better choice to run our application in production.

	workers Integer(ENV['WEB_CONCURRENCY'] || 2)
    threads_count = Integer(ENV['MAX_THREADS'] || 5)
    threads threads_count, threads_count
              
    preload_app!
              
    rackup      DefaultRackup
    port        ENV['PORT']     || 9292
    environment ENV['RACK_ENV'] || 'development'
              
    on_worker_boot do
       ActiveRecord::Base.establish_connection
    end

#### Procfile
It tells Dokku to use Puma.

	web: bundle exec puma -C config/puma.rb

#### CHECKS
This is the way in Dokku to setup zero downtime deployments. It makes sure that our application is available before pointing to the new container.

	WAIT=8
    ATTEMPTS=6
    /check.txt it_works

Now, we need to create a custom route in our **config/routes.rb** file that handles requests to the **/check.txt** endpoint. Add the following route, which will return the **it_works** text that our CHECKS file is expecting:

	get '/check.txt', to: proc {[200, {}, ['it_works']]}

Reference: [http://dokku.viewdocs.io/dokku/deployment/zero-downtime-deploys/](http://dokku.viewdocs.io/dokku/deployment/zero-downtime-deploys/)

#### .env
This prevents that Dokku uses the Dockerfile that we set for the development environment.

	BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-ruby.git

### Automatic database migrating and seed

By default, any changes that you make to your Rails app database require that you manually run rake db:migrate to process your migration files and apply your changes to your database.

We can ensure that Dokku does this automatically for you when you deploy by creating an app.json file in your Rails app root, which Dokku will look to for instructions on what it should do when you deploy your App.

Let's create a file named app.json in the root of your Rails app and add the following instructions:

    {
      "name": "foxyred",
      "description": "My awesome Rails app, running on Dokku!",
      "keywords": [
        "dokku",
        "rails"
      ],
      "scripts": {
        "dokku": {
          "postdeploy": "bundle exec rake db:migrate && bundle exec rake db:seed"
        }
      }
    }

This is telling dokku that after your deploy is successful, run bundle exec rake db:migrate automatically to handle any changes you made to your database between app versions

### Deploy

Add Git Remote

	$ git remote add dokku dokku@your-droplet-ip:foxyred

Push the app!

	$ git push dokku master

This is the command! After upload the code you will see how Dokku is deploying the application.

### Rails commands
Type the following command to run migrations. You can run every bundle or rake command.

	$ ssh dokku@your-droplet-ip run foxyred rake db:reset


## Finish Setup

Open a browser and go to your droplet ip. Then click on **Hostname** field and change for current domain name **foxy.red**, later check the option 'Use virtualhost naming for apps' and by last push **Finish Setup** button.

![enter image description here](http://i.imgur.com/hLDzcKV.jpg)

### Domain Configuration

Check out the following article for detailed instructions on [how to set up your domain name](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-host-name-with-digitalocean) to point to your new Rails app running on Dokku.

Now that you have your droplet, domain name and app ready to go, point the dokku app to root domain name of the dokku server.

    $ dokku domains:add foxyred foxy.red

Reference: [http://dokku.viewdocs.io/dokku/configuration/domains/](http://dokku.viewdocs.io/dokku/configuration/domains/)


### Set up a TLS/SSL certificate

Install dokku-letsencrypt 

	$ dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git

Setup email

	$ dokku config:set --no-restart foxyred DOKKU_LETSENCRYPT_EMAIL=admin@foxy.red

Install certificate

	$ dokku letsencrypt foxyred

That's all!

Reference: [https://github.com/dokku/dokku-letsencrypt](https://github.com/dokku/dokku-letsencrypt)