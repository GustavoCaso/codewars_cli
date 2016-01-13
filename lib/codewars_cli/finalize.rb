module CodewarsCli
  class Finalize
    include Helpers
    def self.find(kata_name, language)
      _check_for_api_key
      if kata_name
        new(kata_name, language, Configuration.api_key).finalize
      else
        error "ERROR: You must provide the name of the kata"
        exit(1)
      end
    end

    attr_reader :kata_name, :language, :api_key

    def initialize(kata_name, language, api_key)
      @kata_name = kata_name
      @language = language || Configuration.language
      @api_key = api_key
    end

    def finalize
      response = client.finalize(kata: _kata)
      if response.success
        info('Your Kata has been uploaded and finish')
      else
        error("There has been an error finalizing your kata #{response.reason}")
      end
    end

    private

    def client
      @client ||= Client.connection(api_key)
    end

    def _kata
      Dir.chdir(_kata_path) do
        description_content = File.read(FileCreator::DESCRIPTION_FILE_NAME)
        project_id = description_content.match(/Project ID: (.*)/)[1]
        solution_id = description_content.match(/Solution ID: (.*)/)[1]
        OpenStruct.new(project_id: project_id, solution_id: solution_id)
      end
    end

    def _kata_path
      path = File.join(ENV['HOME'], Configuration.folder, kata_name, language)
      unless File.exist?(path)
        presenter.display_katas_info(kata_name, language)
        exit(1)
      end
      path
    end
  end
end
