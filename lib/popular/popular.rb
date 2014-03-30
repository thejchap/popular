module Popular

  module Popular

    extend ActiveSupport::Concern

    included do |base|
      has_many :friendships, class_name: 'Popular::Friendship', as: :popular_model, dependent: :destroy
      has_many :friends, through: :friendships, source_type: base

      include ActiveSupport::Callbacks
      define_callbacks :befriend

      [:before_befriend, :after_befriend].each do |callback|
        send callback
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

    module ClassMethods

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
