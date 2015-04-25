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
          original = relation.dataset.to_a.first
          index = original_dataset.data.index(original)
          original_dataset.update(index, tuple)
          original_dataset.write
        end

        def original_dataset
          @original_dataset ||= relation.dataset.connection.new_dataset
        end
      end
    end
  end
end
