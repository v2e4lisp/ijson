module Ijson
  module Literal
    def method_missing(name, *args, &block)
      name.to_s
    end
  end
end
