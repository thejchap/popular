module Popular

  module Popular

    def self.included base

      base.class_eval do

        has_many :friendships, class_name: 'Popular::Friendship', as: :popular_model, dependent: :destroy
        has_many :friends, through: :friendships, source_type: base

      end

    end

    # Adds a friend to an instance's friend's list
    # 
    # @param [Object] new_friend a popular_model that the instance is not already friends with
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #   user.befriend other_user
    #
    #   user.friends_with? other_user #=> true
    def befriend new_friend
      friendships.create friend: new_friend
    end

    # Adds a friend to an instance's friend's list
    # Similar to .befriend, but will raise an error if the operation is not successful
    # 
    # @param [Object] new_friend a popular_model that the instance is not already friends with
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #   user.befriend! other_user
    #   user.reload
    #   user.friends_with? other_user # => true
    def befriend! new_friend
      friendships.create! friend: new_friend
    end

    # Removes a friend from an instance's friend's list
    # 
    # @param [Object] friend a popular_model in this instance's friends list
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #   user.befriend other_user
    #   user.unfriend other_user
    #
    #   user.friends_with? other_user # => false
    def unfriend friend
      friendships.where( friend: friend ).first.destroy
    end

    # Helper method for finding whether or not the instance is friends with 
    # another given popular_model
    # 
    # @param [Object] popular_model
    # @return [Boolean] if the instance has popular_model as a friend
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #
    #   user.friends_with? other_user #=> false
    #
    #   user.befriend other_user
    #
    #   user.friends_with? other_user #=> true
    def friends_with? popular_model
      friendships.where( friend: popular_model ).any?
    end

  end

end
