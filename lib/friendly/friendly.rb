module Friendly

  module Friendly

    def self.included base

      base.class_eval do

        has_many :friendships, class_name: 'Friendly::Friendship', as: :friendly_model, dependent: :destroy
        has_many :friends, through: :friendships, source_type: base

      end

    end

    def befriend new_friend
      friendships.create friend: new_friend
    end

  end

end
