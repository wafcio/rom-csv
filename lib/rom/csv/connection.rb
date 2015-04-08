module ROM
  module CSV
    class Connection
      attr :path

      def initialize(path)
        @path = path
      end

      def dataset
        Dataset.new(data)
      end

      def headers
        data.headers
      end

      def data
        @data ||= ::CSV.table(path).by_row!
      end
    end
  end
end
