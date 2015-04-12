require 'rom/csv/commands/common'

module ROM
  module CSV
    module Commands
      class Create < ROM::Commands::Create
        include Common

        def execute(tuples)
          insert_tuples = Array([tuples]).flatten.map do |tuple|
            attributes = input[tuple]
            validator.call(attributes)
            attributes.to_h
          end

          insert(insert_tuples)
        end

        def insert(tuples)
          new_headers = get_new_headers(tuples)
          update_current_data(new_headers)

          append(tuples)
          write_file

          tuples
        end

        def append(tuples)
          id = last_id + 1
          tuples.each_with_index do |tuple, index|
            id = id + index
            data << ordered_values(tuple.merge(id: id))
          end
        end
      end
    end
  end
end
