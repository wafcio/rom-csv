require 'rom/commands'
require 'rom/commands/delete'

module ROM
  module CSV
    module Commands
      class Delete < ROM::Commands::Delete
        def execute
          original = dataset.to_a.first
          dataset.delete(original)
          dataset.write
          [original]
        end

        def dataset
          target.dataset
        end
      end
    end
  end
end
