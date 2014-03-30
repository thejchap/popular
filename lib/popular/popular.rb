module Popular
  # Namespace for methods included in popular models
  module Popular

    extend ActiveSupport::Concern

    included do |base|
      has_many :friendships, class_name: 'Popular::Friendship', as: :popular_model, dependent: :destroy
      has_many :friends, through: :friendships, source_type: base
      has_many :inverse_friendships, class_name: 'Popular::Friendship', as: :friend, foreign_key: :friend_id
      has_many :inverse_friends, through: :inverse_friendships, source: :popular_model, source_type: base

      include ActiveSupport::Callbacks
      define_callbacks :befriend, :unfriend

      [:before_unfriend, :after_unfriend, :before_befriend, :after_befriend].each do |callback|
        send callback
      end

      aliases = {
        befriend: [:follow],
        befriend!: [:follow!],
        friends_with?: [:following?],
        unfriend: [:unfollow]
      }

      aliases.each do |method, links|
        links.each { |linked_method| alias_method( linked_method, method ) }
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
      run_callbacks :befriend do
        friendships.create friend: new_friend
      end
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
    #
    #   user.friends_with? other_user # => true
    def befriend! new_friend
      run_callbacks :befriend do
        friendships.create! friend: new_friend
      end
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
      run_callbacks :unfriend do
        friendships.where( friend: friend ).first.destroy
      end
    end

    # Helper method for determining whether instances are mutual friends
    # 
    # @param [Object] popular_model
    # @return [Boolean] if both instances have befriended eachother
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #
    #   user.befriend other_user
    #   other_user.befriend user
    #
    #   user.mutual_friends_with? other_user #=> true
    def mutual_friends_with? popular_model
      friends_with?( popular_model ) && friended_by?( popular_model )
    end

    # Helper method for finding whether or not the instance has befriended
    # another given popular_model
    # 
    # Helper method for finding whether or not the instance has 
    # been befriended by another given popular_model
    # 
    # @param [Object] popular_model
    # @return [Boolean] if the instance has been friended by another popular_model
    #
    # @example
    #   user = User.create name: "Justin"
    #   other_user = User.create name: "Jenny"
    #
    #   user.friended_by? other_user #=> false
    #
    #   other_user.befriend user
    #
    #   user.friended_by? other_user #=> true
    def friended_by? popular_model
      inverse_friends.include? popular_model
    end

    # Helper method for finding whether or not the instance has befriended
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
      friends.include? popular_model
    end

    # ClassMethods included in popular models
    module ClassMethods

      # after_unfriend callback convenience class method
      #
      # @example
      #
      #   class User < ActiveRecord::Base
      #     after_unfriend :do_something_amazing
      #
      #     def do_something_amazing
      #       puts name
      #     end
      #   end
      #
      #   user = User.create name: "Justin"
      #   another_user = User.create name: "Jenny"
      #
      #   user.befriend another_user
      #   user.unfriend another_user #=> "Justin"
      def after_unfriend *args, &blk
        set_callback :unfriend, :after, *args, &blk
      end

      # before_unfriend callback convenience class method
      #
      # @example
      #
      #   class User < ActiveRecord::Base
      #     before_unfriend :do_something_amazing
      #
      #     def do_something_amazing
      #       puts name
      #     end
      #   end
      #
      #   user = User.create name: "Justin"
      #   another_user = User.create name: "Jenny"
      #
      #   user.befriend another_user
      #   user.unfriend another_user #=> "Justin"
      def before_unfriend *args, &blk
        set_callback :unfriend, :before, *args, &blk
      end

      # before_befriend callback convenience class method
      #
      # @example
      #
      #   class User < ActiveRecord::Base
      #     before_befriend :do_something_amazing
      #
      #     def do_something_amazing
      #       puts name
      #     end
      #   end
      #
      #   user = User.create name: "Justin"
      #   another_user = User.create name: "Jenny"
      #
      #   user.befriend another_user #=> "Justin"
      def before_befriend *args, &blk
        set_callback :befriend, :before, *args, &blk
      end

      # after_befriend callback convenience class method
      #
      # @example
      #
      #   class User < ActiveRecord::Base
      #     after_befriend :do_something_amazing
      #
      #     def do_something_amazing
      #       puts name
      #     end
      #   end
      #
      #   user = User.create name: "Justin"
      #   another_user = User.create name: "Jenny"
      #
      #   user.befriend another_user #=> "Justin"
      def after_befriend *args, &blk
        set_callback :befriend, :after, *args, &blk
      end
    end
  end

end
