# Popular
[![Gem Version](https://badge.fury.io/rb/popular.png)](http://badge.fury.io/rb/popular)
[![Build Status](https://travis-ci.org/thejchap/popular.svg?branch=master)](https://travis-ci.org/thejchap/popular)
[![Code Climate](https://codeclimate.com/github/thejchap/popular.png)](https://codeclimate.com/github/thejchap/popular)
[![Code Coverage](https://codeclimate.com/github/thejchap/popular/coverage.png)](https://codeclimate.com/github/thejchap/popular)
[![Inline docs](http://inch-pages.github.io/github/thejchap/popular.png)](http://inch-pages.github.io/github/thejchap/popular)
[![Dependency Status](https://gemnasium.com/thejchap/popular.svg)](https://gemnasium.com/thejchap/popular)

Popular is a friendship gem designed for Rails/ActiveRecord models.

- RubyGems: ( https://rubygems.org/gems/popular )
- Website: ( http://thejchap.github.io/popular )
- RDoc: ( http://rubydoc.info/github/thejchap/popular/master/frames )

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
@sam.friends_with? @jackson         #=> false
@sam.friended_by? @jackson          #=> false

@sam.befriend @jackson
@sam.friends_with? @jackson         #=> true

@sam.unfriend @jackson
@sam.friends_with? @jackson         #=> false

@jackson.befriend @sam
@sam.friended_by? @jackson          #=> true

@sam.befriend @jackson
@sam.mutual_friends_with? @jackson  #=> true
```

### Aliases

In Popular, `befriend` is synonomous with `follow`, so if it better fits the context of your application, you can use
follow methods/relations instead. For example:

```ruby
@sam.follow @jackson
@sam.following? @jackson          #=> true

@jackson.follow @sam
@sam.followers.include? @jackson  #=> true
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

### Customization

Popular is intended to provide basic utilities around self-referential relationships in social apps.
Often, more customization is necessary. If you would like to store more information around the friendship,
Popular provides a hook to connect its `friendship` model to a user defined `friendship_profile` model. 
This allows Popular to remain somewhat lightweight and factor out only the code that is repeated  alot between apps,
while allowing flexibility where it is needed.

Do to this, create a `FriendshipProfile` model that belongs to `friendship`, and has whatever custom attributes
you want

```ruby
rails g model FriendshipProfile friendship:belongs_to meeting_location:string meeting_latitude:float meeting_longitude:float
rake db:migrate
```

Then, in your Popular model, just set the `friendship_profile` option to true:

```ruby
class User < ActiveRecord::Base
  popular friendship_profile: true
end
```

Now, everytime a `friendship` is created, an accompanying `friendship_profile` will be attached to it, allowing you to define
as many custom attributes as you wish in a separate table

## Related gems

If Popular isn't quite what you're looking for, here are some other useful gems in the same category:

- Amistad ( https://github.com/raw1z/amistad )
- Friendable ( https://github.com/yuki24/friendable )

*Disclaimer: I have not used either of the above gems*


## Resources

Popular was heavily inspired by this screencast: ( http://railscasts.com/episodes/163-self-referential-association?view=asciicast )


## Plans for the future
- Add generator for entire `Frienship` resource that includes FriendshipsController, routes, etc
- More aliases
- Define your own `FriendshipProfile` class
- Callbacks for `befriended` or `followed`



## Contributing

1. Fork it ( http://github.com/thejchap/popular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
