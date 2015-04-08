require 'rom/relation'

module ROM
  module CSV
    # Relation subclass of CSV adapter
    #
    # @example
    #   class Users < ROM::Relation[:csv]
    #   end
    #
    # @api public
    class Relation < ROM::Relation
      # Restrict a dataset
      #
      # @api public
      def restrict(criteria = nil)
        __new__(dataset.dataset.restrict(criteria))
      end

      # Project a dataset
      #
      # @api public
      def project(*names)
        __new__(dataset.dataset.project(*names))
      end

      # Sort a dataset
      #
      # @api public
      def order(*names)
        __new__(dataset.dataset.order(*names))
      end
    end
  end
end
