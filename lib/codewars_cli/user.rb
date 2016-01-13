module CodewarsCli
  class User
    include Helpers
    def self.fetch(username_or_id)
      check_for_api_key
      new(username_or_id)
    end

    attr_reader :username_or_id
    def initialize(username_or_id)
      @username_or_id = username_or_id
    end

    def get_user
      client.user(username_or_id: username_or_id)
    end

    def print_description
      presenter.display_user_info(get_user)
    end
  end
end
