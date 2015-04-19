require 'singleton'

module ROM
  module CSV
    class Path
      include ::Singleton

      attr_accessor :path

      def self.set(name, value)
        instance.path ||= {}
        instance.path[name] = value
      end

      def self.get(name)
        instance.path[name]
      end
    end
  end
end
