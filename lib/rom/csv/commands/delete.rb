require 'rom/commands'
require 'rom/commands/delete'

module ROM
  module CSV
    module Commands
      class Delete < ROM::Commands::Delete
        def execute
          original = dataset.to_a.first
          original_dataset.delete(original)
          original_dataset.write
          [original]
        end

        def dataset
          target.dataset
        end

        def original_dataset
          @original_dataset ||= dataset.connection.new_dataset
        end
      end
    end
  end
end
