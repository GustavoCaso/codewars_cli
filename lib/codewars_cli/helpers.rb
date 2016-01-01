require 'codewars_cli/concerns/attributes_methods'
module CodewarsCli
  module Helpers
    def extend_object(object)
      object.extend(Concerns::AttributesMethods)
      object
    end
  end
end
