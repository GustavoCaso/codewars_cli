module CodewarsCli
  class Cli < Thor
    desc 'config SUBCOMMAND ...ARGS', 'Write options in the configuration file'
    subcommand 'config', Config

    desc 'user USERNAME_OR_ID', 'return user information'
    def user(username_or_id)
      user = User.fetch(username_or_id)
      user.print_description
    end

    desc 'next_kata', 'create markdown page with kata information'
    option :language, banner: " Ruby | C++ | Javascript | Java | Coffescript | Haskell | Clojure"
    def next_kata
      kata = Kata.fetch(options[:language])
      kata.create_file
    end
  end
end
