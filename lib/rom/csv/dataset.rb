require 'rom/csv/dataset/read_operations'
require 'rom/csv/dataset/write_operations'

module ROM
  module CSV
    # Dataset for CSV
    #
    # @api public
    class Dataset
      include ReadOperations
      include WriteOperations

      attr_reader :connection, :data

      def initialize(connection, data)
        @connection = connection
        @data = data
      end

      def headers
        if data.any?
          data.first.keys
        else
          []
        end
      end

      def each
        data.each { |d| yield(d) }
      end

      alias_method :to_a, :data

      def first
        data.first
      end

      def count
        data.count
      end
    end
  end
end
