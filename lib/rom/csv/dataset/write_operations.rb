module ROM
  module CSV
    class Dataset
      module WriteOperations
        def <<(tuples)
          if tuples.is_a?(Array)
            tuples.each { |tuple| data << tuple }
          else
            data << tuples
          end
        end

        def update(index, tuple)
          data[index].merge!(tuple)
        end

        def delete(tuple)
          data.delete(tuple)
        end

        def write
          ::CSV.open(path, 'wb', options) do |csv|
            csv << headers

            data.each do |tuple|
              csv << ordered_values(tuple)
            end
          end
        end

        private

        def ordered_values(tuple)
          headers.map { |header| tuple[header] }
        end
      end
    end
  end
end
