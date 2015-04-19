require 'rom/memory/dataset'

module ROM
  module CSV
    # Dataset for CSV
    #
    # @api public
    class Dataset < ROM::Memory::Dataset
      # Convert each CSV::Row to a hash
      #
      # @api public
      def self.row_proc
        -> row { row.to_hash }
      end

      # HACK: sort_by aka project in rom doesn't work with nil value
      def empty_value
        ' '
      end

      def headers
        data.headers
      end

      def add_headers(headers)
        if headers.any?
          data.each do |d|
            headers.each { |header| d[header] = empty_value }
          end
        end
      end

      def ordered_values(tuple)
        headers.map{ |header| tuple[header] || empty_value }
      end

      def write(path)
        ::CSV.open(path, 'wb') do |csv|
          csv << headers

          data.each do |tuple|
            csv << ordered_values(tuple)
          end
        end
      end
    end
  end
end
