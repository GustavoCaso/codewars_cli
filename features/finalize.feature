Feature: Finalize command
  Background:
    Given a mocked home directory
    Given the config file with:
      """
      :api_key: 'fake_api'
      :language: 'java'
      :folder: 'fake_home'
      """

  Scenario: No provide kata name
    And I run `codewars finalize`
    Then the output should contain exactly:
      """
      ERROR: You must provide the name of the kata
      """

  Scenario: No api key provided
    Given a mocked home directory
    Given the config file with:
      """
      :api_key: ''
      :language: 'java'
      :folder: fake_home
      """
    And I run `codewars finalize`
    Then the output should contain exactly:
      """
      ERROR: You must config the api_key
      SOLUTION: Set up with `config api_key KEY`
      """

  @stub_finalize_response
  Scenario: Valid finalize kata
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars finalize --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      Your Kata has been uploaded and finish
      """

  @stub_finalize_invalid_response
  Scenario: Valid finalize kata
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars finalize --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      There has been an error finalizing your kata not found
      """
