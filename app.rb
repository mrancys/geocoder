# frozen_string_literal: true

require_relative './config/boot'
require_relative './lib/maps_wrapper'

class App < Sinatra::Base
  get '/address/*' do
    query = params['splat']
    fail_empty_query if query.join.empty? || query.nil?

    response = MapsWrapper.new.geocode(query.join(' '))
    validate_response(response)

    cordinates = response[:results].fetch(0).fetch(:geometry).fetch(:location)
    cordinates.to_json
  end

  def fail_empty_query
    message = { error: 'Address empty.' }

    halt 400, message.to_json
  end

  def validate_response(response)
    return if response[:status].empty?

    if response[:status] != 'OK'
      message = { error: response[:error_message] || response[:status] }

      halt 400, message.to_json
    end
  end
end
