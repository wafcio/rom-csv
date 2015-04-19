require 'rom/commands'
require 'rom/commands/create'

module ROM
  module CSV
    module Commands
      class Create < ROM::Commands::Create
        def execute(tuples)
          insert_tuples =  [tuples].flatten.map do |tuple|
            attributes = input[tuple]
            validator.call(attributes)
            attributes.to_h
          end

          insert(insert_tuples)
          insert_tuples
        end

        def insert(tuples)
          dataset << tuples
          dataset.write
        end

        def dataset
          relation.dataset
        end
      end
    end
  end
end
