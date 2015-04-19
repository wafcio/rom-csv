require 'rom/commands'
require 'rom/commands/create'

module ROM
  module CSV
    module Commands
      class Create < ROM::Commands::Create
        def execute(tuples)
          insert_tuples = Array([tuples]).flatten.map do |tuple|
            attributes = input[tuple]
            validator.call(attributes)
            attributes.to_h
          end

          insert(insert_tuples)
        end

        def insert(tuples)
          headers = get_new_headers(tuples)
          relation.dataset.add_headers(headers)
          append_tuples(tuples)
          relation.dataset.write(ROM::CSV::Path.get(relation.name))
          tuples
        end

        def append_tuples(tuples)
          csv_rows(tuples).each do |csv_row|
            relation.dataset << csv_row
          end
        end

        def get_new_headers(tuples)
          tuple_headers(tuples) - current_headers
        end

        def current_headers
          relation.dataset.headers
        end

        def tuple_headers(tuples)
          tuples.map(&:keys).flatten
        end

        def csv_rows(tuples)
          tuples.map do |tuple|
            ordered_values = relation.dataset.ordered_values(tuple.to_hash)
            ::CSV::Row.new(current_headers, ordered_values)
          end
        end
      end
    end
  end
end
