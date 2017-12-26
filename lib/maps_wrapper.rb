# frozen_string_literal: true

require_relative '../config/boot.rb'
require 'net/http'

class MapsWrapper
  API_PATH = CONFIGURATION.fetch(:GOOGLE_GEOCODING_BASE_URI)

  def initialize(options = {})
    @query = options.fetch(:query, key: CONFIGURATION.fetch(:GOOGLE_GEOCODING_API))
  end

  def geocode(address = '')
    url = path_with_params(API_PATH, @query.merge!(address: address))

    begin
      response = Net::HTTP.get(URI(url))
    rescue StandardError => error
      { status: :error, error_message: error.message }
    else
      JSON.parse(response, symbolize_names: true)
    end
  end

  private

  def path_with_params(path, params)
    encoded_params = URI.encode_www_form(params)
    [path, encoded_params].join('?')
  end
end
