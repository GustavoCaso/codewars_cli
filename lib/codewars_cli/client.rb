module CodewarsCli
  module Client
    def self.connection
      CodewarsApiRuby.api_key = Configuration.api_key
      CodewarsApiRuby
    end
  end
end
