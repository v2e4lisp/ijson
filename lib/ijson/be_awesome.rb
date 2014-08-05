require "awesome_print"

# Fix indent
AwesomePrint.defaults = {:indent => -2}

module Ijson
  module BeAwesome
    def self.included(base)
      base.class_eval {
        def inspect
          self.ai
        end
      }
    end
  end
end
