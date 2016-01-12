require 'codewars_cli/runner'
require 'aruba/cucumber'
require 'aruba/in_process'

Before do
  @real_path = ENV['HOME']
  @fake_home = File.join('/tmp','fake_home')
  FileUtils.mkdir_p(@fake_home)
  set_environment_variable 'HOME', @fake_home
end

After do
  ENV['HOME'] = @real_home
  FileUtils.rm_rf @fake_home, :secure => true
end

Aruba.configure do |config|
  config.command_launcher = :in_process
  config.main_class = CodewarsCli::Runner
end

