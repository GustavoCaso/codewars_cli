module CodewarsCli
  module Client
    def self.connection
      CodewarsClient.api_key = Configuration.api_key
      CodewarsClient
    end
  end
end
