module CodewarsCli
  class Finalize
    include Helpers
    include FileParserHelpers
    def self.find(kata_name, language)
      check_for_api_key
      if kata_name
        new(kata_name, language).finalize
      else
        error "ERROR: You must provide the name of the kata"
        exit(1)
      end
    end

    attr_reader :kata_name, :language

    def initialize(kata_name, language)
      @kata_name = kata_name
      @language = language || Configuration.language
    end

    def finalize
      response = client.finalize(kata: _parse_description_file(kata_name, language))
      if response.success
        info('Your Kata has been uploaded and finish')
      else
        error("There has been an error finalizing your kata #{response.reason}")
      end
    end
  end
end
