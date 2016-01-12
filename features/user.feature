Feature: Display the user information in the terminal

  Scenario: Passing a valid username prints a correct message
    Given the config file with:
      """
      api_key: 'iT2dAoTLsv8tQe7KVLxe'
      language: 'ruby'
      folder: ''
      """
    When I run `bundle exec codewars user GustavoCaso`
    Then the output should contain exactly "Displaying information about GustavoCaso"
