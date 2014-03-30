module Popular

  class Friendship < ::ActiveRecord::Base

    belongs_to :popular_model, polymorphic: true
    belongs_to :friend, polymorphic: true

  end

end
