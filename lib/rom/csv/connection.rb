require 'rom/csv/dataset'

module ROM
  module CSV
    class Connection
      attr_reader :path, :options

      def initialize(path, options = {})
        @path = path
        @options = options
      end

      def first
        new_dataset.first
      end

      def to_a
        new_dataset.to_a
      end

      def each
        new_dataset.data.each { |d| yield(d) }
      end

      def join(*args)
        new_dataset.join(*args)
      end

      def restrict(criteria = nil)
        new_dataset.restrict(criteria)
      end

      def project(*args)
        new_dataset.project(*args)
      end

      def order(*args)
        new_dataset.order(*args)
      end

      def count
        new_dataset.count
      end

      def new_dataset
        Dataset.new(self, load_data)
      end

      private

      def load_data
        data = []
        load_data_from_file.each { |d| data << d.to_hash }
        data
      end

      def load_data_from_file
        ::CSV.table(path, options).by_row!
      end
    end
  end
end
