# Clipster

[<img src="https://secure.travis-ci.org/kwbock/clipster.png" alt="Build Status" />](http://travis-ci.org/kwbock/clipster)

Code snippets before they were cool.

An OpenSource Rails engine to add clipboard code sharing to your existing Ruby on Rails applications. Great for internal code sharing. Try it out at http://www.developerdan.com/clipster
* Features
	* Syntax highlighting
	* Expiring clips
	* Public and private clips
	* Atom Feed for public clips
	* Optional user integration

## Production

Add clipster to your Gemfile and then bundle install

    gem 'clipster'
    bundle install

or if you aren't using Bundler, run

    gem install 'clipster'

Mount the Clipster Engine in your applcations routes.rb like follows.

    mount Clipster::Engine, :at => '/clipster'

cd to your apps root and run

    rails g clipster:install
    rake db:migrate

Restart your application and you should be able to access the engine at http://domain.tld/clipster

## Development

cd into your test application directory's lib folder and run the following

    git clone https://github.com/kwbock/clipster.git

Add the following to your app's Gemfile

    gem 'clipster', :path => './lib/clipster'

Add the following to your app's routes.rb

    mount Clipster::Engine, :at => '/clipster'

cd to your apps root and run

    rake clipster:install:migrations
    rake db:migrate

Launch your server and navigate to https://localhost:3000/clipster to confirm the engine was mounted correctly

## Enabling User Intgration


* Edit the `clipster.rb` initializer to enable user integration with Clipster.
	* set `config.associates_clip_with_user = true`
	* set `config.user_class = "YourUserClass"` if your users class is something other than `User`.	NOTE: user_class must be a string.
	* set `config.user_display_attribute = "display field"` if your display field is something other than `email`.
	* NOTE: Clipster's user integration default settings are set up for [Devise](https://github.com/plataformatec/devise). Following the standard Devise install and enabling `config.associates_clip_with_user = true` is the minimum necessary to enable user integration.

Restart your application and you should be able to access the engine at http://domain.tld/clipster

### Upgrade Notes

* v0.4.1 may break backwards compatibility due to some changes to the Clip model. It may be best to start with a fresh clips table with 0.4.1. 

### Todos

* Get tests written for all features, preferably with mocks if thats possible.
