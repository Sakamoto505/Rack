require_relative 'time_format'

class App

  def call(env)
    @request = Rack::Request.new(env)
    response

    [status, headers, body]
  end

  private

  def response
    return different_url if @request.path_info != '/time'
    @format = TimeFormat.new(@request.params)
    if @format.valid_format?
      valid_format
    else
      invalid_format
    end
  end

  def status
    @status
  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end

  def body
    ["#{@message}\n"]
  end

  def valid_format
    @status = 200
    @message = @format.result
  end

  def invalid_format
    @status = 400
    @message = "Unknown time format: #{@format.wrong_format}"
  end

  def different_url
    @status = 404
    @message = "Page not found"
  end
end
