module Friendly

  module Friendly

    def self.included base

      base.class_eval do

        has_many :friendships, class_name: 'Friendly::Friendship', as: :friendly_model, dependent: :destroy
        has_many :friends, through: :friendships, source_type: base

      end

    end

    # Adds a friend to an instance's friend's list
    # 
    # @param [FriendlyModel] a friendly_model that the instance is not already friends with
    def befriend new_friend
      friendships.create friend: new_friend
    end

    # Removes a friend from an instance's friend's list
    # 
    # @param [FriendlyModel] a friendly_model in this instance's friends list
    def unfriend friend
      friendships.where( friend: friend ).first.destroy
    end

    # Helper method for finding whether or not the instance is friends with another given friendly_model
    # 
    # @param [FriendlyModel] a friendly_model
    # @return [Boolean] if the instance has friendly_model as a friend
    def friends_with? friendly_model
      friendships.where( friend: friendly_model ).any?
    end

  end

end
