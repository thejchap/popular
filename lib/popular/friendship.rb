module Popular

  # Friendship class. Provides self-referential join for popular_models and their friends
  class Friendship < ::ActiveRecord::Base
    belongs_to :popular_model, polymorphic: true
    belongs_to :friend, polymorphic: true
    has_one :friendship_profile

    validates_presence_of :friend, :popular_model

    # Ensures that popular_models cannot add themselves as a friend
    validate :ensure_popular_model_different_from_friend

    # If the user has created a friendship profile table, this will get attached
    # after create
    after_create :create_friendship_profile!,
      if: Proc.new { |friendship| friendship.popular_model.class.friendship_profile }

    private

    def create_friendship_profile!
      if defined? FriendshipProfile
        super
      else
        warn "You have set friendship_profile: true in your popular model, however no FriendshipProfile model exists"
        warn "To fix this, run 'rails g model FriendshipProfile friendship:belongs_to'"
      end
    end

    # Checks friend against popular_model.
    #
    # TODO add more descriptive error message/i18n
    def ensure_popular_model_different_from_friend
      errors.add( :friend ) if friend == popular_model
    end

  end

end
