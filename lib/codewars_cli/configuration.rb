require 'yaml'
module CodewarsCli
  module Configuration
    include Helpers
    CONFIG_FILE = '.codewars.rc.yml'
    CONFIG_CONTENTS = {
      api_key: '',
      language: '',
      folder: '',
    }

    def self.write(value, key, options)
      create_config_file unless File.exists? config_file
      update_value(value, key) && return if options['update'] && !send(key).empty?
      if !send(key).empty?
        info "Do you want to overwrite #{key} provide --update option"
      else
        info "Updating config file located in: #{config_file} with #{key}: #{value}"
        update_value(value, key)
      end
    end

    def self.update_value(value, key)
      content = config_data
      content.send(:[]=, key, value)
      File.open(config_file, 'w') do |f|
        f.write(content.to_yaml)
      end
    end

    def self.create_config_file
      File.open(config_file, 'w+') { |f| f.write(CONFIG_CONTENTS.to_yaml) }
    end

    def self.api_key
      config_data[:api_key] if config_data
    end

    def self.language
      config_data[:language] if config_data
    end

    def self.folder
      config_data[:folder] if config_data
    end

    def self.config_file
      File.join(ENV['HOME'], CONFIG_FILE)
    end

    def self.config_data
      YAML::load_file(config_file) if File.exists? config_file
    end
  end
end
