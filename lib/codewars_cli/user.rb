module CodewarsCli
  class User
    def self.fetch(username_or_id)
      api_key = Configuration.api_key
      fail Thor::Error, "ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY`" if api_key.empty?
      new(username_or_id, api_key).get_user
    end

    attr_reader :username_or_id, :api_key
    def initialize(username_or_id, api_key)
      @username_or_id = username_or_id
      @api_key = api_key
    end

    def get_user
      client = set_client
      client.user(username_or_id: username_or_id)
    end

    private

    def set_client
      @client ||= Client.connection(api_key)
    end
  end
end
