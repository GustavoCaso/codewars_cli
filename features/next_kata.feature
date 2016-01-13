Feature: Will fetch the next kata and create a description markdown file
  Background:
    Given a mocked home directory
  Scenario: Without api key
    Given the config file with:
      """
      :api_key: ''
      :language: 'ruby'
      :folder: fake_home
      """
    When I run `codewars next_kata`
    Then the output should contain "ERROR: You must config the api_key\nSOLUTION: Set up with `config api_key KEY"

  @stub_next_kata_response
  Scenario: With out folder
    Given the config file with:
      """
      :api_key: 'iT2dAoTLsv8tQe7KVLxe'
      :language: 'ruby'
      :folder: ''
      """
    When I run `codewars next_kata`
    Then the output should contain "ERROR: You must config the folder\nSOLUTION: Set up with `config folder FOLDER_LOCATION"

  Scenario: Without language
    Given the config file with:
      """
      :api_key: 'iT2dAoTLsv8tQe7KVLxe'
      :language: ''
      :folder: fake_home
      """
    When I run `codewars next_kata`
    Then the output should contain "ERROR: You must config the language for this command\nSOLUTION: Set up with `config language LANGUAGE`"

  @stub_next_kata_response
  Scenario: Using the language from the config file
    Given the config file with:
      """
      :api_key: 'iT2dAoTLsv8tQe7KVLxe'
      :language: 'ruby'
      :folder: fake_home
      """
    When I run `codewars next_kata`
    Then the output should contain "Creating Kata descrition file"
    And the directory "~/fake_home/scrabble-best-word/ruby" should exist
    And the file "~/fake_home/scrabble-best-word/ruby/description.md" should exist
    And the file "~/fake_home/scrabble-best-word/ruby/solution.rb" should exist


