Feature: Display the user information in the terminal
  Background:
    Given a mocked home directory
    Given the config file with:
      """
      :api_key: 'iT2dAoTLsv8tQe7KVLxe'
      :language: ''
      :folder: ''
      """

  @stub_user_response
  Scenario: Passing a valid username prints a correct message
    When I run `codewars user GustavoCaso`
    Then the output should contain "Displaying information about GustavoCaso"

  @stub_user_invalid_response
  Scenario: Passing invavalid username prints error message
    When I run `codewars user e62e8g`
    Then the output should contain "ERROR: Fetching Information\nREASON: NOT FOUND"

