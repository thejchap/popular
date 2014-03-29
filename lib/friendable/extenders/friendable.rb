module Friendable
  module Extenders
    module Friendable

      def friendable?
        false
      end

      def friendable *args
        require 'friendable/friendable'
        
        class_eval do
          def self.friendable?
            true
          end
        end
      end

    end
  end
end
