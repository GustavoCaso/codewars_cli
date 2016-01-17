module CodewarsCli
  class Cli < Thor
    desc 'config SUBCOMMAND ...ARGS', 'Write options in the configuration file'
    subcommand 'config', Config

    desc 'user USERNAME_OR_ID', 'return user information'
    def user(username_or_id)
      User.fetch(username_or_id).print_description
    end

    desc 'next_kata', 'start a new session training session and create markdown page with kata information'
    option :language, banner: " ruby | c | javascript | java | coffescript | haskell | clojure"
    def next_kata
      Kata.fetch(options[:language]).create_file
    end

    desc 'submit_kata', 'upload solution to codewars'
    option :language, banner: 'The language of the kata if not provided will get the deafult one'
    def submit_kata(kata_name)
      SubmitKata.find(kata_name, options[:language]).upload_kata
    end

    desc 'finalize', 'finalize kata'
    option :language, banner: 'The language of the kata if not provided will get the deafult one'
    def finalize(kata_name)
      Finalize.find(kata_name, options[:language])
    end
  end
end
