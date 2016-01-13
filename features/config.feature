Feature: Hability to store configuration settings
  Background:
    Given a mocked home directory
  Scenario: Setup the apikey
    Given the config file do not exists
    When I run `codewars config api_key test_api`
    Then the output should contain "Updating config file with api_key: test_api"
    And the config file contain:
      """
      :api_key: test_api
      :language: ''
      :folder: ''
      """

  Scenario: Setup the language
    Given the config file do not exists
    When I run `codewars config language ruby`
    Then the output should contain "Updating config file with language: ruby"
    And the config file contain:
      """
      :api_key: ''
      :language: ruby
      :folder: ''
      """

  Scenario: Setup the folder
    Given the config file do not exists
    When I run `codewars config folder dev/test`
    Then the output should contain "Updating config file with folder: dev/test"
    And the config file contain:
      """
      :api_key: ''
      :language: ''
      :folder: dev/test
      """
  Scenario: Setup the api_key with existing api_key and not overwrite others keys
    Given the config file with:
      """
      :api_key: Im_Here
      :language: ruby
      :folder: ''
      """
    When I run `codewars config api_key new_key`
    Then the output should contain "Do you want to overwrite api_key provide --update option"
    When I run `codewars config api_key new_key --update`
    And the config file contain:
      """
      :api_key: new_key
      :language: ruby
      :folder: ''
      """


