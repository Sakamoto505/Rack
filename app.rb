require_relative 'time_format'

class App

  def call(env)
    r = Rack::Request.new(env)
      return response(404, "not found") if r.path_info != '/time'
    @format = TimeFormat.new(r.params)
    if @format.valid_format?
      response(200, @format.success_format)
    else
      response(400, @format.wrong_format)
    end
  end

  private

  def response(code, text)
    response = Rack::Response
    response.status = code
    response['Content-Type'] = 'text/plain'
    response.write(text)
  end
end
