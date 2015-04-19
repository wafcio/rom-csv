require 'csv'

require 'rom'
require 'rom/csv/version'
require 'rom/csv/repository'
require 'rom/csv/relation'
require 'rom/csv/path'

ROM.register_adapter(:csv, ROM::CSV)
