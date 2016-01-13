Feature: Submit Kata and will return a deferred response
  Background:
    Given a mocked home directory
    Given the config file with:
      """
      :api_key: 'fake_api'
      :language: 'java'
      :folder: fake_home
      """

  Scenario: Wrong kata name
    When I run `codewars submit_kata --kata-name=uyevuce`
    Then the output should contain "The is no kata with that name 'uyevuce' and language 'java'\nTo help here is a list of all your katas order by language"

  Scenario: No provide kata name
    And I run `codewars submit_kata`
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
    And I run `codewars submit_kata`
    Then the output should contain exactly:
      """
      ERROR: You must config the api_key
      SOLUTION: Set up with `config api_key KEY`
      """

  @stub_submit_kata_response @stub_deferred_valid_response
  Scenario: valid response
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      Your solution has been uploaded waiting for results
      The solution has passed all tests on the server.
      If you are happy with your solution please type\ncodewars finalize --kata-name=anything-to-integer --language=java
      """

  @stub_submit_kata_response_invalid
  Scenario: valid response
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      There has been an error uploading the kata please try agin later
      Reason: No code provided
      """

  @stub_submit_kata_response @stub_deferred_unsubmitted_response
  Scenario: unsubmitted deferred
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      Your solution has been uploaded waiting for results
      Can't get a result of tests on the server. Try it again.
      """

  @stub_submit_kata_response @stub_deferred_invalid_response
  Scenario: invalid response
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb369116fb896c00002a
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      Your solution has been uploaded waiting for results
      The solution has not passed tests on the server. Response:
      -e: Value is not what was expected (Test::Error)
      """

  Scenario: Incomplete description file missing Project ID
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Solution ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      The Project ID is missing from your description.md
      """

  Scenario: Incomplete description file missing Solution ID
    Given a file "~/fake_home/anything-to-integer/java/solution.java" with "solved_kata"
    And a file "~/fake_home/anything-to-integer/java/description.md" with:
      """
      ## Description of the kata
      Project ID: 562cbb379116fb896c00002c
      Other information
      """
    And I run `codewars submit_kata --kata-name=anything-to-integer`
    Then the output should contain exactly:
      """
      The Solution ID is missing from your description.md
      """
