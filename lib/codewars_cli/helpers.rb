require 'codewars_cli/concerns/attributes_methods'
module CodewarsCli
  module Helpers
    def self.included(base)
      base.extend(self)
    end

    def _check_for_api_key
      fail Thor::Error ,"ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY`" if Configuration.api_key.empty?
    end

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
