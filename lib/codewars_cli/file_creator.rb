require 'fileutils'
require 'erb'

module CodewarsCli
  class FileCreator
    include Helpers
    DESCRIPTION_FILE_NAME = 'description.md'
    def self.create(kata_info, language)
      folder_path = Configuration.folder
      fail Thor::Error, "ERROR: You must config the folder\nSOLUTION: Set up with `config folder FOLDER_LOCATION`" if folder_path.empty?
      new(kata_info, language, folder_path).create_file
    end

    attr_reader :data, :language, :folder_path
    def initialize(data, language, folder_path)
      @data = extend_object(data)
      @language = language
      @folder_path = folder_path
    end

    def create_file
      _create_missing_dirs unless File.exists?(_destination_path)
      _fill_template_with_kata_info
    end

    private

    def _create_missing_dirs
      FileUtils.mkdir_p(_destination_path)
    end

    def _fill_template_with_kata_info
      b = _create_binding
      template = File.read(File.expand_path('../template.erb', __FILE__))
      content = ERB.new(template).result(b)
      _create_markdown_file(content)
    end

    def _create_binding
      b = binding
      (data.attributes.merge({language: language})).each do |k,v|
        b.local_variable_set(k.to_sym, v)
      end
      b
    end

    def _create_markdown_file(content)
      Dir.chdir(_destination_path) do
        info("Creating Kata descrition file")
        File.open(DESCRIPTION_FILE_NAME,'w') { |f| f.write content }
        info("Creating Kata solution file")
        File.open(_solution_file_name, 'w+')
      end
    end

    def _solution_file_name
      "solution.#{_language_extension}"
    end

    def _language_extension
      CodewarsCli::Language::EXTENSIONS[language]
    end

    def _destination_path
      File.join(ENV['HOME'],folder_path,data.slug,language)
    end
  end
end
