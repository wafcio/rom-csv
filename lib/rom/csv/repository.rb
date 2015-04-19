require 'rom/repository'
require 'rom/csv/dataset'
require 'rom/csv/commands'

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
      # Uses CSV.table which passes the following csv options:
      # * headers: true
      # * converters: numeric
      # * header_converters: :symbol
      #
      # @param path [String] path to csv
      # @param options [Hash] options passed to Dataset and next to CSV.table
      #
      # @api private
      #
      # @see CSV.table
      def initialize(path, options = {})
        @path = path
        @options = options
        @datasets = {}
      end

      # Return dataset with the given name
      #
      # @param name [String] dataset name
      # @return [Dataset]
      #
      # @api public
      def [](name)
        datasets[name]
      end

      # Register a dataset in the repository
      #
      # If dataset already exists it will be returned
      #
      # @param name [String] dataset name
      # @return [Dataset]
      #
      # @api public
      def dataset(name)
        datasets[name] = Dataset.new(path, options)
      end

      # Check if dataset exists
      #
      # @param name [String] dataset name
      #
      # @api public
      def dataset?(name)
        datasets.key?(name)
      end

      private

      # @api private
      attr_reader :path, :options, :datasets
    end
  end
end
