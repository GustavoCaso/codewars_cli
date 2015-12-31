require 'codewars_cli/concerns/attributes_methods'

module CodewarsCli
  module Helpers
    def pretty_print(object)
      object.extend(Concerns::AttributesMethods)
      STDOUT.puts object.attributes.to_yaml
    end
  end
end
