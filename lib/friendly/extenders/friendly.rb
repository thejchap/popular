module Friendly

  # Namespace for classes and modules that handle including the library's modules
  module Extenders

    # Namespace for classes and modules that handle making a given model friendable
    module Friendly

      # Helper method for determining whether or not a model is friendable
      #
      # @return [Boolean] whether or not the including class is friendable
      def friendly?
        false
      end

      # Includes the module in a given class
      #
      # @overload friendable *args
      #   @param [Hash] options
      def friendly *args
        require 'friendly/friendly'
        
        class_eval do
          def self.friendly?
            true
          end
        end
      end

    end
  end

end
