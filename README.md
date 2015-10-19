[![Code Climate](https://codeclimate.com/repos/53e0f88169568076c90127f3/badges/3c50ac5ad654152b21d1/gpa.svg)](https://codeclimate.com/repos/53e0f88169568076c90127f3/feed)

INSTALLATION
============

* Requirements
==============

  This project requires ruby 2.1.7

  The version used in production is  ----

  - Redis Server Installed
  - Memcache Installed

* Database creation

* Installation steps
====================

  Copy and configure yml.example files to their respective .yml ones and configure them

	config/application.yml.example
	config/database.yml.example
	config/settings.yml.example
	config/sidekiq.yml.example
	config/newrelic.yml.example
	config/redis.yml.example
	config/settings/*

  Execute:

    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:seed   (yes to all)

* Database
==========

  If you make any changes in database you must annotate the changes in the model.

  	bundle exec annotate -s -i -p


* REDIS
=======

Configuration
-------------
  The configuration is in config/settings.yml inside the key redis. It's advisable to give
  different database numbers for developing and testing environments. If you have other apps working with Redis, you may
  want to configure database numbers or listening port values for all these applications
  
  Chamber is used to crypt sensible data. If you want to crypt a configuration entry you must do the following:

    1. Check if certificates are in config dir (pe
    2. prepend the entry in the configuration .yml with _secure_ (e.g. _secure_api_key)
    3. run 'bundle exec rake chamber:secure'
    4. prepend the entries in script/deploy files with _secure_
    5. run 'bundle exec rake chamber:secure <environment>' for each environment
  

* Sidekiq
=========

  To start sidekiq

  sidekiq -C config/sidekiq.yml

* I18n
======
 TODO


* SAMPLE DATA
=============
  To initialize sample data you can run:

    rake db:populate

  or execute something like:

    FactoryGirl.create :address

    #this will create 10 doctors with some roles
    FactoryGirl.create_list(:doctor, 10)

* TEST
=======
  Execute test: rake test:all 


* i18n files
 ===========
 TODO


* DEPLOY
=========

  This proyect is deployed to two diferent instances using the integration branch.
  By default is done using the spainselectservicios user.

  * servicios (http://spainselect-servicios.dev.aspgems.com):
    cap staging deploy
  * servicios (http://-----):
    cap production deploy


Deploy sequence
---------------

  Ensure branch to deploy is updated to the commit you want to deploy.

    cap 'stage' deploy:prepare

  Stage can be any of the defined ones (currently they are: production, staging).

  Then, deploy.

    cap 'stage' deploy

  During the deploy process you will be asked for a tag message

    Please enter tag_message: ||

  When the deploy finishes a tag will be set in the repo branch. Use a meaningul message.

  WARNING! If you have uncommited changes in your working copy the tag creation will fail and the whole deploy will be
  considered failed. If you just did a prepare you are safe, otherwise, check your working copy before deploying.
  
Design
------
  
  Template for design taken from:
  
    http://codepen.io/ZURBFoundation/pen/oGlJI
    