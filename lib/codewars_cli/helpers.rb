require 'codewars_cli/concerns/attributes_methods'
module CodewarsCli
  module Helpers
    def extend_object(object)
      object.extend(Concerns::AttributesMethods)
      object
    end

    def info(msg, color=:green)
      presenter.info(msg, color)
    end

    def error(msg)
      presenter.error(msg)
    end

    def presenter
      @presenter ||= Presenter.new
    end
  end
end
