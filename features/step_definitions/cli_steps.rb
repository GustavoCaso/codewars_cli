Given(/^the config file with:$/) do |string|
  step 'a file "~/.codewars.rc.yml" with:', string
end

Given(/^the config file do not exists$/) do
  step 'a file "~/.codewars.rc.yml" does not exist'
end

Then(/^the config file contain:$/) do |string|
  step 'the file "~/.codewars.rc.yml" should contain:', string
end
