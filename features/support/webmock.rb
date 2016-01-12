require 'webmock/cucumber'


CODEWARS_BASE = 'https://www.codewars.com'
CODEWARS_API = '/api/v1'

Before('@stub_user_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_get("/users/GustavoCaso")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'user.json')
end

Before('@stub_user_invalid_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  stub_get("/users/e62e8g")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'invalid_user.json', 404)
end


def stub_get(url)
  stub_request(:get, "#{CODEWARS_BASE}#{CODEWARS_API}#{url}")
end

def stub_post(url)
  stub_request(:post, "#{CODEWARS_BASE}#{CODEWARS_API}#{url}")
end

def json_response(file, status=200)
  {
    body: fixture(file),
    status: status,
    headers: { content_type: 'application/json; charset=utf-8' }
  }
end

def fixture(file)
  File.new(File.join(fixture_path,file))
end

def fixture_path
  File.expand_path('../../fixtures', __FILE__)
end
