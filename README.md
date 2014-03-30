# Popular
[![Gem Version](https://badge.fury.io/rb/popular.png)](http://badge.fury.io/rb/popular)
[![Build Status](https://travis-ci.org/thejchap/popular.svg?branch=master)](https://travis-ci.org/thejchap/popular)
[![Code Climate](https://codeclimate.com/github/thejchap/popular.png)](https://codeclimate.com/github/thejchap/popular)
[![Code Coverage](https://codeclimate.com/github/thejchap/popular/coverage.png)](https://codeclimate.com/github/thejchap/popular)
[![Inline docs](http://inch-pages.github.io/github/thejchap/popular.png)](http://inch-pages.github.io/github/thejchap/popular)
[![Dependency Status](https://gemnasium.com/thejchap/popular.svg)](https://gemnasium.com/thejchap/popular)

Popular is a friendship gem designed for Rails/ActiveRecord models.

## Installation

Add this line to your application's Gemfile:

    gem 'popular'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install popular

### Database Migration

Popular uses a friendships table to store friendship relationships.
To get up and running, use the following command:

    rails g popular:migration
    rake db:migrate

## Usage

### Model

To get started using Popular, simply add `popular` to your model, (ie: `app/models/user.rb`)

```ruby
class User < ActiveRecord::Base
  popular
end
```

## Contributing

1. Fork it ( http://github.com/thejchap/popular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
