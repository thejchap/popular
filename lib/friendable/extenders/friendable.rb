module Friendable

  # Namespace for classes and modules that handle including the library's modules
  module Extenders

    # Namespace for classes and modules that handle making a given model friendable
    module Friendable

      # Helper method for determining whether or not a model is friendable
      #
      # @return [Boolean] whether or not the including class is friendable
      def friendable?
        false
      end

      # Includes the module in a given class
      #
      # @overload friendable *args
      #   @param [Hash] options
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
