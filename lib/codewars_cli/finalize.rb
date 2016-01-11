module CodewarsCli
  class Finalize
    include Helpers
    def self.find(kata_name, language)
      api_key = Configuration.api_key
      fail Thor::Error, "ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY`" if api_key.empty?
      if kata_name
        new(kata_name, language, api_key).finalize
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

    def finalize
      response = client.finalize(kat: _kata)
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
      fail Thor::Error, "ERROR: The kata you specify is not found in your folder" unless File.exist?(path)
      path
    end
  end
end
