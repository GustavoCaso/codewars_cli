module CodewarsCli
  class Kata
    include Helpers
    def self.fetch(language)
      _check_for_api_key
      if language
        new(language, Configuration.api_key)
      else
        default_language = Configuration.language
        fail Thor::Error, "ERROR: You must config the language for this command\nSOLUTION: Set up with `config language LANGUAGE`" if default_language.empty?
        new(default_language, Configuration.api_key)
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
