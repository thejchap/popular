if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'sqlite3'
require 'popular'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Schema.define version: 1 do

  create_table :friendships do |t|
    t.references :popular_model, polymorphic: true,  null: false
    t.references :friend, polymorphic: true, null: false
  end

  create_table :popular_models

end

RSpec.configure do |config|
  config.order = 'random'
end

def clean_database
  [PopularModel, Popular::Friendship].each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end
