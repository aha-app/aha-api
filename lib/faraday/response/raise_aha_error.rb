require 'faraday'
require 'multi_json'

# @api private
module Faraday
  class Response::RaiseAhaError < Response::Middleware
    ERROR_MAP = {
      400 => AhaApi::BadRequest,
      401 => AhaApi::Unauthorized,
      403 => AhaApi::Forbidden,
      404 => AhaApi::NotFound,
      406 => AhaApi::NotAcceptable,
      422 => AhaApi::UnprocessableEntity,
      500 => AhaApi::InternalServerError,
      501 => AhaApi::NotImplemented,
      502 => AhaApi::BadGateway,
      503 => AhaApi::ServiceUnavailable
    }

    def on_complete(response)
      key = response[:status].to_i
      raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
    end
  end
end
