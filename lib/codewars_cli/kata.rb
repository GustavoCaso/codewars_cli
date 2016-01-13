module CodewarsCli
  class Kata
    def self.fetch(language)
      api_key = Configuration.api_key
      fail Thor::Error, "ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY`" if api_key.empty?
      if language
        new(language, api_key)
      else
        default_language = Configuration.language
        fail Thor::Error, "ERROR: You must config the language for this command\nSOLUTION: Set up with `config language LANGUAGE`" if default_language.empty?
        new(default_language, api_key)
      end
    end

    attr_reader :language, :api_key
    def initialize(language, api_key)
      @language = language
      @api_key = api_key
    end

    def get_kata
      client = set_client
      client.next_kata(language: language)
    end

    def create_file
      FileCreator.create(get_kata, language)
    end

    private

    def set_client
      @client ||= Client.connection(api_key)
    end
  end
end
