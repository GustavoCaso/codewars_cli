require 'ostruct'

module CodewarsCli
  class SubmitKata
    include Helpers
    def self.find(kata_name, language)
      _check_for_api_key
      if kata_name
        new(kata_name, language, Configuration.api_key)
      else
        error("ERROR: You must provide the name of the kata")
        exit(1)
      end
    end

    attr_reader :kata_name, :language, :api_key

    def initialize(kata_name, language, api_key)
      @kata_name = kata_name
      @language = language || Configuration.language
      @api_key = api_key
    end

    def upload_kata
      kata_info = _get_kata_id_from_description_file
      code = _get_kata_solution_code
      response = client.attemp_solution(kata: kata_info, code: code)
      Deferred.new(kata_name, language, response, client)
    end

    private

    def _get_kata_solution_code
      Dir.chdir(_kata_path) do
        File.read(_solution_file)
      end
    end

    def _get_kata_id_from_description_file
      Dir.chdir(_kata_path) do
        description_content = File.read(FileCreator::DESCRIPTION_FILE_NAME)
        project_id  = _fetch_info(description_content, 'Project ID')
        solution_id = _fetch_info(description_content, 'Solution ID')
        OpenStruct.new(project_id: project_id, solution_id: solution_id)
      end
    end

    def _fetch_info(content, string)
      regex = %r(#{string}: (.*))
      if match = content.match(regex)
        match[1]
      else
        error("The #{string} is missing from your description.md")
        exit(1)
      end
    end

    def _solution_file
      "solution.#{_language_extension}"
    end

    def _language_extension
      CodewarsCli::Language::EXTENSIONS[language]
    end

    def _kata_path
      path = File.join(ENV['HOME'], Configuration.folder, kata_name, language)
      unless File.exist?(path)
        presenter.display_katas_info(kata_name, language)
        exit(1)
      end
      path
    end

    def client
      @client ||= Client.connection(api_key)
    end
  end
end
