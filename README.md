# CodewarsCli

With this command you would be able to enjoy [Codewars](http://www.codewars.com/), a site where you can practice your coding skills

## Installation

Or install it yourself as:

    $ gem install codewars_cli

## Usage

The start working you would need an account in [Codewars](http://www.codewars.com/join), if you have it already great!.
To start using the CLI you will need setup up a few things first.

##Comands

### Configuration
There are a few commands you can use to configuration your CLI, the most important one is to setup your api_key, first you will need to get it from your account of [Codewars](https://www.codewars.com/users/edit).

To setup your api_key `codewars config api_key YOUR_API_KEY`.

There are other options you can configure **language** and **folder**.

The language is your favorite option for downloading. Also you can specify everytime you start a new session what language you want use.

To setup your language `codewars config language LANGUAGE`.

### Valid Languages

```
ruby
javascript
java
coffeescript
haskell
clojure
c
python
```


The folder option is where all your description file will be downloaded.

The file structure will be: `~/YOUR_FOLDER/#{NAME_OF_THE_KATA}/#{LANGUAGE}`

To setup your language `codewars config folder FOLDER`.

Once you have finish the setup up,  you can changed but you will have to pass a flag `update` to tell the application to overwrite it.

##### Example

To overwrite your api_key `codewars config api_key YOUR_API_KEY --update`.

### User
Display all the information related to a Codewars user in your Terminal.

`codewars user USERNAME_OR_ID` will display the information well formatted for your eyes.

![User_dispay_info](https://cloud.githubusercontent.com/assets/4672858/12372466/8bb2e012-bc58-11e5-8fac-325108ebfdf6.png)

### Next Kata
Start a new session of training and download all the information related to a new kata.
This command will create a `description.md` file with all the information of the Kata and some metadata that is need it for submiting the kata later.

Also it will create a `solution.{LANGUAGE_EXTENSION}` file where you should place your code in other to be uploaded when submitting the kata.

`codewars next_kata` [Valid languages](#valid-languages)

To specify a a different language just add a new param as the language you want to train.

`codewars next_kata javascript`

### Submit Kata
When submitting a kata, the application will upload your code to the Codewars server and will wait for the server to respond with the result, depending on the respond, the kata could be **finalized** or keep working on it.

To submit use `codewars submit KATA_NAME`

By Default it will use you predefined language, but you can always specify a different one:

`codewars submit KATA_NAME --language=LANGUAGE` [Valid languages](#valid-languages)


In case the name is not correct it will display a formatted list with all your katas order by language to help you.

### Finalize
This is the last step of the process.

To finish a kata type `codewars finalize KATA_NAME`

As well you can specify the language of the kata `codewars finalize KATA_NAME --language=LANGUAGE` [Valid languages](#valid-languages)

It will close the kata four you.




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GustavoCaso/codewars_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

