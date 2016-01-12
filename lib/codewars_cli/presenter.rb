module CodewarsCli
  class Presenter < Thor
    include Helpers
    no_commands do
      def display_user_info(object)
        return error(_user_error_message(object)) unless object.status == 200
        info("Displaying information about #{object.username}", :magenta)
        object = extend_object(object)
        attr = object.attributes
        languague_attributes = attr.delete(:languages)
        attr.each do |k,v|
          _print_attributes(k,v)
        end
        print_table(_build_column_info(languague_attributes))
      end

      def display_katas_info(kata_name, language)
        error("The is no kata with that name '#{kata_name}' and language '#{language}'")
        info('To help here is a list of all your katas order by language', :magenta)
        _katas_info.each do |language, katas|
          _print_attributes(language, katas.join(','))
        end
      end

      def info(message, color)
        say set_color(message, color)
      end

      def error(message)
        say set_color(message, :red)
      end
    end

    private

    def _katas_info
      Dir.chdir(_katas_folder) do
        Dir.glob('**/*').select do |fn|
          File.directory?(fn) && fn.include?('/')
        end.map{|arr| arr.split('/')}.inject({}) do |hash, arr|
          hash[arr.last.to_sym] = []
          hash[arr.last.to_sym] << arr.first
          hash
        end
      end
    end

    def _katas_folder
      File.join(ENV['HOME'], Configuration.folder)
    end

    def _user_error_message(object)
      "ERROR: Fetching Information\nREASON: #{object.reason.upcase}"
    end

    def _build_column_info(info)
      info.inject([_set_headers]) do |arr, (key,value)|
        arr << [
                set_color(key, :yellow),
                value.values.map{|v| set_color(v, :blue)}
               ].flatten
        arr
      end
    end

    def _set_headers
      ['languages', 'rank', 'name', 'color', 'score'].map {|h| set_color(h, :green)}
    end

    def _print_attributes(key, value, indent = false )
      if value.is_a? Hash
        say set_color("#{key}:", :yellow) + "\n"
        value.each { |k,v| _print_attributes(k,v, true) }
      else
        line = set_color("#{key}: ", :green) + set_color("#{value}", :blue) + "\n"
        line = "  #{line}" if indent
        say line
      end
    end
  end
end
