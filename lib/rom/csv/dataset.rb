require 'rom/csv/dataset/load_data'
require 'rom/csv/dataset/read_operations'

module ROM
  module CSV
    # Dataset for CSV
    #
    # @api public
    class Dataset
      include LoadData
      include ReadOperations

      attr_reader :path, :options, :data, :headers

      def initialize(path, options = {})
        @path = path
        @options = options
        reload
      end

      def each
        data.each { |d| yield(d) }
      end

      def to_a
        output = data
        reload
        output
      end

      def first
        output = data.first
        reload
        output
      end
    end
  end
end
