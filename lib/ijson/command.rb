module Ijson
  module Command
    def self.included(base)
      base.send(:include, Hash) if base == ::Hash
      base.send(:include, Array) if base == ::Array
    end

    def self.use_binding_of env
      Ripl.shell.binding = env.instance_eval { binding }
    end

    def self.root=(value)
      use_binding_of value
      ChangeDir.root = value
    end

    module Hash
      def ls(value=nil)
        value ? self[value].ls : self.keys
      end
    end

    module Array
      def ls(value=nil)
        value ? self[value].ls : (0...size).to_a
      end
    end

    class ChangeDir
      class << self
        attr_accessor :root
        attr_accessor :current_path
      end

      def klass
        self.class
      end

      def initialize(env, paths, options={})
        @env = env
        @root = options[:root]
        @paths = paths
      end

      def is_root?
        @root
      end

      def run
        env = new_env
        return "invalid path #{@paths}" unless env

        klass.current_path = absolute_path
        Command.use_binding_of env
      end

      def new_env
        root = @root ? klass.root : @env
        @paths.inject(root) {|acc, path|
          case acc[path]
          when Hash, Array
            acc[path]
          else
            false
          end
        }
      end

      def absolute_path
        @root ? @paths : Array(klass.current_path) + @paths
      end
    end

    ChangeDir.current_path = []

    def cd *paths
      ChangeDir.new(self, paths).run
    end

    def cd! *paths
      ChangeDir.new(self, paths, :root => true).run
    end

    def pwd
      ChangeDir.current_path.map {|i| "[#{i}]" }.join
    end

    def cat *paths
      paths.inject(self) {|a, e| a[e]}
    end

  end
end
