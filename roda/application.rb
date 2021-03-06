require_relative 'get'
require_relative 'post'

module Benchmarker
  class Application < Roda
    plugin :multi_route

    route do |r|
      # NOTE: cannot define POST else where. Also POST has to be defined before
      # the `r.run Get`
      r.post "books" do
        json_string = request.body.read
        json_body = Rack::Utils.parse_nested_query(json_string)
        response['Content-Type'] = 'application/json'
        json_body.to_json
      end

      r.run Get
    end
  end
end
