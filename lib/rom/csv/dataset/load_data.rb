module ROM
  module CSV
    class Dataset
      module LoadData
        def reload
          @data = []
          data = load_data_from_file

          @headers = data.headers
          data.each do |d|
            @data << d.to_hash
          end
        end

        def load_data_from_file
          ::CSV.table(path, options).by_row!
        end
      end
    end
  end
end
