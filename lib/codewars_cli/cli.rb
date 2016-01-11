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
    option :language, banner: " ruby | cs | javascript | java | coffescript | haskell | clojure"
    def next_kata
      kata = Kata.fetch(options[:language])
      kata.create_file
    end

    desc 'submit_kata', 'upload solution to codewars'
    option :kata_name, banner: 'The name of the kata you want to upload'
    option :language, banner: 'The language of the kata if not provided will get the deafult one'
    def submit_kata
      kata = SubmitKata.find(options[:kata_name], options[:language])
      kata.upload_kata
    end

    desc 'finalize', 'finalize kata'
    option :kata_name, banner: 'The name of the kata you want to finalize'
    option :language, banner: 'The language of the kata if not provided will get the deafult one'
    def finalize
      Finalize.find(options[:kata_name], options[:language])
    end
  end
end
