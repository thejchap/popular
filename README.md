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

@sam = User.create name: "Samuel"
@jackson = User.create name: "Jackson"

# Adding and removing friends
@sam.friends_with? @jackson   #=> false
@sam.friended_by? @jackson    #=> false

@sam.befriend @jackson

@sam.friends_with? @jackson   #=> true

@sam.unfriend @jackson

@sam.friends_with? @jackson   #=> false

@jackson.befriend @sam

@sam.friended_by? @jacson     #=> true
```

### Callbacks

Popular provides callbacks that are fired around friendship creation. Available callbacks are:
  - after_befriend
  - before_befriend
  - after_unfriend
  - before_unfriend


```ruby
class User < ActiveRecord::Base
  popular
  after_befriend :notify_friendship_created
  after_unfriend :notify_unfriended

  def notify_friendship_created
    puts "Friendship created successfully"
  end

  def notify_unfriended
    puts ":("
  end
end

@justin = User.create name: "Justin"
@jenny = User.create name: "Jenny"

@justin.befriend @jenny #=> "Friendship created successfully"
@justin.unfriend @jenny #=> ":("
```

## Contributing

1. Fork it ( http://github.com/thejchap/popular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
