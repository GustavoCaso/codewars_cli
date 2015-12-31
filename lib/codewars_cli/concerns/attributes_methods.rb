module  CodewarsCli
  module Concerns
    module AttributesMethods
      def attributes
        _build_attributes(self)
      end

      private

      def _build_attributes(object)
        object.instance_variables.inject({}) do |hash, key|
          hash[key.to_s.gsub('@', '').to_sym] = object.instance_variable_get(key)
          hash
        end
      end
    end
  end
end
