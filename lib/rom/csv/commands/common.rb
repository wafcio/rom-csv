require 'rom/csv/commands/common'

module ROM
  module CSV
    module Commands
      module Common
        def update_current_data(new_headers)
          new_headers.each do |header|
            data.each { |d| d[header] = nil }
          end
        end

        def get_new_headers(tuples)
          tuple_headers(tuples) - data.headers
        end

        def tuple_headers(tuples)
          tuples.map(&:keys).flatten.uniq
        end

        def last_id
          data.map { |d| d[:id] }.max
        end

        def ordered_values(hash)
          data.headers.map{ |header| hash[header] }
        end

        def write_file
          File.open(relation.dataset.path, 'w') do |file|
            file.write(data.to_csv)
          end
        end

        def data
          relation.dataset.data
        end
      end
    end
  end
end
