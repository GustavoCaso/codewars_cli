require 'ostruct'

module CodewarsCli
  module FileParserHelpers
    def _parse_description_file(kata_name, language)
      Dir.chdir(_kata_path(kata_name, language)) do
        description_content = File.read(FileCreator::DESCRIPTION_FILE_NAME)
        project_id  = _fetch_info(description_content, 'Project ID')
        solution_id = _fetch_info(description_content, 'Solution ID')
        OpenStruct.new(project_id: project_id, solution_id: solution_id)
      end
    end

    def _fetch_info(content, string)
      regex = %r(#{string}: (.*))
      if match = content.match(regex)
        match[1]
      else
        error("The #{string} is missing from your description.md")
        exit(1)
      end
    end

    def _kata_path(kata_name, language)
      path = File.join(ENV['HOME'], Configuration.folder, kata_name, language)
      unless File.exist?(path)
        presenter.display_katas_info(kata_name, language)
        exit(1)
      end
      path
    end
  end
end
