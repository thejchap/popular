module Popular

  # Friendship class. Provides self-referential join for popular_models and their friends
  class Friendship < ::ActiveRecord::Base

    belongs_to :popular_model, polymorphic: true
    belongs_to :friend, polymorphic: true

    validates_presence_of :friend, :popular_model

    # Ensures that popular_models cannot add themselves as a friend
    validate :ensure_popular_model_different_from_friend

    private

    # Checks friend against popular_model.
    #
    # TODO add more descriptive error message/i18n
    def ensure_popular_model_different_from_friend
      errors.add( :friend ) if friend == popular_model
    end

  end

end
