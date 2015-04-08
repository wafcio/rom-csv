require 'rom/repository'
require 'rom/csv/connection'
require 'rom/csv/dataset'

# Ruby Object Mapper
#
# @see http://rom-rb.org/
module ROM
  # CSV support for ROM
  #
  # @example
  #   require 'rom/csv'
  #   require 'ostruct'
  #
  #   setup = ROM.setup(:csv, "./spec/fixtures/users.csv")
  #   setup.relation(:users) do
  #     def by_name(name)
  #       dataset.find_all { |row| row[:name] == name }
  #     end
  #   end
  #
  #   class User < OpenStruct
  #   end
  #
  #   setup.mappers do
  #     define(:users) do
  #       model User
  #     end
  #   end
  #
  #   rom = setup.finalize
  #   p rom.read(:users).by_name('Jane').one
  #   # => #<User id=2, name="Jane", email="jane@doe.org">
  #
  # **Note: rom-csv is read only at the moment.**
  #
  # @api public
  module CSV
    # CSV repository interface
    #
    # @api public
    class Repository < ROM::Repository
      # Expect a path to a single csv file which will be registered by rom to
      # the given name or :default as the repository.
      #
      # @param path [String] path to csv
      #
      def initialize(path)
        @connection = Connection.new(path)
      end

      # Return dataset with the given name
      #
      # @param name [String] dataset name
      # @return [Dataset]
      #
      # @api public
      def [](_name)
        connection
      end

      # Register a dataset in the repository
      #
      # If dataset already exists it will be returned
      #
      # @param name [String] dataset name
      # @return [Dataset]
      #
      # @api public
      def dataset(_name)
        connection
      end

      # Check if dataset exists
      #
      # @param name [String] dataset name
      #
      # @api public
      def dataset?(_name)
        File.exists?(connection.path)
      end
    end
  end
end
