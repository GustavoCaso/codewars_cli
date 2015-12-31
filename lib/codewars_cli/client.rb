module CodewarsCli
  module Client
    def self.connection(api_key)
      CodewarsApiRuby.api_key = api_key
      CodewarsApiRuby
    end
  end
end
