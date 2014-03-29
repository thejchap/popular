require 'sqlite3'
require 'friendable'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

UnfriendableUser = Class.new ActiveRecord::Base

class FriendableUser < ActiveRecord::Base
  friendable
end


RSpec.configure do |config|
  config.order = 'random'
end
