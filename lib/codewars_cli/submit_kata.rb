module CodewarsCli
  class SubmitKata
    include GenericHelpers
    include FileParserHelpers
    def self.find(kata_name, language)
      check_for_api_key
      if kata_name
        new(kata_name, language)
      else
        error("ERROR: You must provide the name of the kata")
        exit(1)
      end
    end

    attr_reader :kata_name, :language

    def initialize(kata_name, language)
      @kata_name = kata_name
      @language = language || Configuration.language
    end

    def upload_kata
      code = _get_kata_solution_code(kata_name, language)
      response = client.attemp_solution(kata: _parse_description_file(kata_name, language), code: code)
      Deferred.new(kata_name, language, response, client)
    end

    private

    def _get_kata_solution_code(kata_name, language)
      Dir.chdir(_kata_path(kata_name, language)) do
        File.read(_solution_file)
      end
    end

    def _solution_file
      "solution.#{_language_extension}"
    end

    def _language_extension
      CodewarsCli::Language::EXTENSIONS[language]
    end

  end
end
