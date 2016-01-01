module CodewarsCli
  class Config < Thor
    desc 'api_key KEY', 'Set the global configuration for api_key'
    method_options update: :boolean
    def api_key(api_key)
      Configuration.write(api_key, :api_key, options)
    end

    desc 'language LANGUAGE', 'Set the global configuration for language'
    long_desc <<-LONGDESC
      `language LANGUAGE` will store the prefer language for trainnig katas.

      Available options are:
        - Ruby
        - Javascript
        - Java
        - Coffescript
        - Haskell
        - C++
        - Python
        - Clojure
    LONGDESC
    method_options update: :boolean
    def language(language)
      Configuration.write(language, :language, options)
    end

    desc 'folder FOLDER', 'Set the global configuration for folder where all the kata information will be stored'
    long_desc <<-LONGDESC
      `folder FOLDER` will store the prefer location for file information.

      It will create a folder for each language that you train,
      containing the markdown file with all the information about the kata,
      and the file to complete the kata
    LONGDESC
    method_options update: :boolean
    def folder(folder)
      Configuration.write(folder, :folder, options)
    end
  end
end
