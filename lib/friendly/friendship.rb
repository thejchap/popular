module Friendly

  class Friendship < ::ActiveRecord::Base

    belongs_to :friendly_model, polymorphic: true
    belongs_to :friend, polymorphic: true

  end

end
