require 'rom/commands'
require 'rom/commands/update'

module ROM
  module CSV
    module Commands
      class Update < ROM::Commands::Update
        option :original, type: Hash, reader: true

        alias_method :to, :call
        alias_method :set, :call

        def execute(tuple)
          attributes = input[tuple]
          validator.call(attributes)

          changed = diff(attributes.to_h)

          if changed.any?
            update(changed)
          else
            []
          end
        end


        def update(tuple)
          # pks = relation.map { |t| t[primary_key] }

          # puts ROM.repositories.invert[:csv].dataset(relation.name).data.inspect
          # puts

          puts self.inspect
          puts relation.inspect
          # dataset = relation.dataset
          # puts dataset.inspect
          # dataset.update(tuple)
          # dataset.unfiltered.where(primary_key => pks).to_a
        end

        private

        def diff(tuple)
          if original
            Hash[tuple.to_a - (tuple.to_a & original.to_a)]
          else
            tuple
          end
        end
      end
    end
  end
end
