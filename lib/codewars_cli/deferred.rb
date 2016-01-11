module CodewarsCli
  class Deferred
    include Helpers
    REQUEST_TIMES = 10
    attr_reader :kata_name, :language, :response, :client
    def initialize(kata_name, language, response, client)
      @kata_name = kata_name
      @language = language
      @response = response
      @client = client
      _read_deferred do
        info('Your solution has been uploaded waiting for results')
        _handle_deferred_response(_handle_deferred)
      end
    end

    private

    def _read_deferred
      if response.success
        yield
      else
        error('There has been an error uploading the kata please try agin later')
        error("Reason: #{response.reason}")
      end
    end

    def _handle_deferred_response(result)
      _display_info_for_unsubmitted_result if result.nil? || !result.success

      if result.valid
        info 'The solution has passed all tests on the server.'
        info 'If you are happy with your solution please type'
        info "codewars finalize --kata-name=#{kata_name} --language=#{language}", :blue
      else
        error 'The solution has not passed tests on the server. Response:'
        fail Thor::Error, error(result.reason)
      end
    end

    def _display_info_for_unsubmitted_result
      error_message = "Can't get a result of tests on the server. Try it again."
      fail Thor::Error, error(Error)
    end

    def _handle_deferred
      REQUEST_TIMES.times do
        result = client.deferred_response(dmid: response.dmid)
        return result if result.success
        sleep 1
      end
      nil
    end
  end
end
