module Popular
  # Namespace for classes and modules that handle including the library's modules
  module Extenders

    # Namespace for classes and modules that handle making a given model friendly
    module Popular

      # Helper method for determining whether or not a model has included
      # the Popular module
      #
      # @return [Boolean] whether or not the including class has included the module
      def popular?
        false
      end

      # Includes the module in a given class
      #
      # @overload friendable *args
      #   @param [Hash] options
      def popular *args
        require 'popular/popular'
        include ::Popular::Popular
        
        class_eval do
          def self.popular?
            true
          end
        end
      end

    end
  end
end
