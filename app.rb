require_relative 'time_format'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @params = @request.params

    time_request_valid? ? time_response : response(404, 'invalid request')
  end

  private

  def time_request_valid?
    @request.get? && @request.path_info == '/time' && @params['format']
  end

  def time_response
    time_format = TimeFormat.new(@params)

    if time_format.valid?
      response(200, time_format.call)
    else
      response(400, "Unknown time format [#{time_format.invalid.join(', ')}]")
    end
  end

  def response(status, body)
    response = Rack::Response.new
    response.status = status
    response.write body.to_s
    response.add_header('Content-Type', 'text/plain')
    response.finish
  end
end
