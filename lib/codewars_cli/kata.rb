module CodewarsCli
  class Kata
    include GenericHelpers
    def self.fetch(language)
      check_for_api_key
      if language
        new(language)
      else
        default_language = Configuration.language
        fail Thor::Error, "ERROR: You must config the language for this command\nSOLUTION: Set up with `config language LANGUAGE`" if default_language.empty?
        new(default_language)
      end
    end

    attr_reader :language
    def initialize(language)
      @language = language
    end

    def get_kata
      client.next_kata(language: language)
    end

    def create_file
      FileCreator.create(get_kata, language)
    end
  end
end
