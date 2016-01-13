module CodewarsCli
  class User
    include Helpers
    def self.fetch(username_or_id)
      _check_for_api_key
      new(username_or_id, Configuration.api_key)
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

    def print_description
      presenter.display_user_info(get_user)
    end

    private

    def set_client
      @client ||= Client.connection(api_key)
    end
  end
end
