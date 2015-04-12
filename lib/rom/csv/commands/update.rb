require 'rom/csv/commands/common'

module ROM
  module CSV
    module Commands
      class Update < ROM::Commands::Create
        include Common

        def execute(tuple)
          attributes = input[tuple]
          validator.call(attributes)

          puts tuple.inspect
          tuple
        end
      end
    end
  end
end
