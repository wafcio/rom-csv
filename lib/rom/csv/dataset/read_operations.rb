module ROM
  module CSV
    class Dataset
      module ReadOperations
        # Join two datasets
        #
        # @api public
        def join(*args)
          left, right = args.size > 1 ? args : [data, args.first]

          join_map = left.each_with_object({}) { |tuple, h|
            others = right.to_a.find_all { |t| (tuple.to_a & t.to_a).any? }
            (h[tuple] ||= []).concat(others)
          }

          new_data = left.flat_map { |tuple|
            join_map[tuple].map { |other| tuple.merge(other) }
          }

          Dataset.new(connection, new_data)
        end

        # Restrict a dataset
        #
        # @api public
        def restrict(criteria = nil)
          new_data = if criteria
            find_all { |tuple| criteria.all? { |k, v| tuple[k].eql?(v) } }
          else
            find_all { |tuple| yield(tuple) }
          end

          Dataset.new(connection, new_data)
        end

        # Project a dataset
        #
        # @api public
        def project(*names)
          new_data = map { |tuple| tuple.reject { |key| !names.include?(key) } }

          Dataset.new(connection, new_data)
        end

        # Sort a dataset
        #
        # @api public
        def order(*names)
          new_data = sort_by { |tuple| tuple.values_at(*names) }

          Dataset.new(connection, new_data)
        end

        private

        def find_all
          data.select { |d| yield(d) }
        end

        def map
          data.map { |d| yield(d) }
        end

        def sort_by
          data.sort_by { |d| yield(d) }
        end
      end
    end
  end
end
