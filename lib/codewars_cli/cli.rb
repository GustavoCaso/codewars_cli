require 'codewars_cli/helpers'
module CodewarsCli
  class Cli < Thor
    include Helpers

    desc 'config SUBCOMMAND ...ARGS', 'Write options in the configuration file'
    subcommand 'config', Config

    desc 'user USERNAME_OR_ID', 'return user information'
    def user(username_or_id)
      user = User.fetch(username_or_id)
      pretty_print(user)
    end

    desc 'next_kata', 'create markdown page with kata information'
    option :language, banner: " Ruby | C++ | Javascript | Java | Coffescript | Haskell | Clojure"
    def next_kata
      kata = Kata.fect(option[:language])
    end
  end
end
