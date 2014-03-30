module Friendly
  # Namespace for classes and modules that handle including the library's modules
  module Extenders

    # Namespace for classes and modules that handle making a given model friendly
    module Friendly

      # Helper method for determining whether or not a model is friendly
      #
      # @return [Boolean] whether or not the including class is friendly
      def friendly?
        false
      end

      # Includes the module in a given class
      #
      # @overload friendable *args
      #   @param [Hash] options
      def friendly *args
        require 'friendly/friendly'
        include ::Friendly::Friendly
        
        class_eval do
          def self.friendly?
            true
          end
        end
      end

    end
  end
end
