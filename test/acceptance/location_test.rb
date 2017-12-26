require_relative '../test_helper.rb'

class LocationTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    App.new
  end

  def test_happy_path
    get '/address/Berlin'

    assert_equal 200, last_response.status

    coordinates = JSON.parse(last_response.body, symbolize_names: true)
    assert_equal 52.52000659999999, coordinates[:lat]
    assert_equal 13.404954, coordinates[:lng]
  end

  def test_fail_path
    get '/address/QWER'

    assert_equal 400, last_response.status
  end

  def test_empty_path
    get '/address/'

    assert_equal 400, last_response.status

    response = JSON.parse(last_response.body, symbolize_names: true)
    assert_equal "Address empty.", response[:error]
  end

end
