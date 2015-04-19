require 'rom/commands'
require 'rom/commands/update'

module ROM
  module CSV
    module Commands
      class Update < ROM::Commands::Update
        def execute(tuple)
          attributes = input[tuple]
          validator.call(attributes)
          tuple = attributes.to_h

          update(tuple)
          [tuple]
        end

        def update(tuple)
          original = dataset.to_a.first
          index = dataset.data.index(original)
          dataset.update(index, tuple)
          dataset.write
        end

        def dataset
          relation.dataset
        end
      end
    end
  end
end
