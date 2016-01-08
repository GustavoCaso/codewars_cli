module CodewarsCli
  class Presenter < Thor
    include Helpers
    no_commands do
      def display_user_info(object)
        return error_message(object.reason) unless object.status == 200
        say set_color("Displaying information about #{object.username}", :magenta)
        object = extend_object(object)
        attr = object.attributes
        languague_attributes = attr.delete(:languages)
        attr.each do |k,v|
          _print_attributes(k,v)
        end
        print_table(_build_column_info(languague_attributes))
      end

      def info_message(message)
        say set_color(message, :green)
      end

      def error_message(reason)
        say set_color("ERROR: Fetching Information\nREASON: #{reason.upcase}", :red)
      end
    end

    private

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
