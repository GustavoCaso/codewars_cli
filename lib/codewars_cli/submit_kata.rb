require 'ostruct'

module CodewarsCli
  class SubmitKata
    include Helpers
    def self.find(kata_name, language)
      api_key = Configuration.api_key
      fail Thor::Error, "ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY`" if api_key.empty?
      if kata_name
        new(kata_name, language, api_key)
      else
        fail Thor::Error, "ERROR: You must provide the name of the kata"
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
      Deferred.new(kata_name, response, client)
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
        project_id = description_content.match(/Project ID: (.*)/)[1]
        solution_id = description_content.match(/Solution ID: (.*)/)[1]
        OpenStruct.new(project_id: project_id, solution_id: solution_id)
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
      fail Thor::Error, "ERROR: The kata you specify is not found in your folder" unless File.exist?(path)
      path
    end

    def client
      @client ||= Client.connection(api_key)
    end
  end
end
