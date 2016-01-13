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

Before('@stub_next_kata_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  language = 'ruby'
  stub_post("/code-challenges/#{language}/train")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'kata.json')
end

Before('@stub_submit_kata_response') do
  api_key     = 'iT2dAoTLsv8tQe7KVLxe'
  language    = 'ruby'
  project_id  = "562cbb369116fb896c00002a"
  solution_id = "562cbb379116fb896c00002c"
  stub_post("/code-challenges/projects/#{project_id}/solutions/#{solution_id}/attempt")
    .with(
      body: { code: 'solved_kata' },
      headers: { Authorization: api_key }
    ).to_return(json_response 'submit_kata_success.json')
end

Before('@stub_submit_kata_response_invalid') do
  api_key     = 'iT2dAoTLsv8tQe7KVLxe'
  language    = 'ruby'
  project_id  = "562cbb369116fb896c00002a"
  solution_id = "562cbb379116fb896c00002c"
  stub_post("/code-challenges/projects/#{project_id}/solutions/#{solution_id}/attempt")
    .with(
      body: { code: 'solved_kata' },
      headers: { Authorization: api_key }
    ).to_return(json_response 'submit_kata_invalid.json')
end

Before('@stub_deferred_invalid_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  dmid = "4rsdaDf8d"
  stub_get("/deferred/#{dmid}")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'deferred_invalid_response.json')
end

Before('@stub_deferred_valid_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  dmid = "4rsdaDf8d"
  stub_get("/deferred/#{dmid}")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'deferred_valid_response.json')
end

Before('@stub_deferred_unsubmitted_response') do
  api_key = 'iT2dAoTLsv8tQe7KVLxe'
  dmid = "4rsdaDf8d"
  stub_get("/deferred/#{dmid}")
    .with(
      headers: { Authorization: api_key }
    ).to_return(json_response 'deferred_unsubmitted_response.json')
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
