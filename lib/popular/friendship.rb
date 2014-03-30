module Popular

  class Friendship < ::ActiveRecord::Base

    belongs_to :popular_model, polymorphic: true
    belongs_to :friend, polymorphic: true

    validates_presence_of :friend, :popular_model
    validate :ensure_popular_model_different_from_friend

    private

      def ensure_popular_model_different_from_friend
        errors.add( :friend ) if friend == popular_model
      end

  end

end
