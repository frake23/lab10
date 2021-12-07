require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get '/'
    assert_response :success
  end

  test 'should get view in html format by default' do
    post '/calc'
    assert_response :success
    assert_equal 'text/html', @response.media_type
  end

  test 'should get view in xml format' do
    post '/calc.xml'
    assert_response :success
    assert_equal 'application/xml', @response.media_type
  end

  test 'should get view in rss+xml format' do
    post '/calc.rss'
    assert_response :success
    assert_equal 'application/rss+xml', @response.media_type
  end

  test 'should get different responds for different requests' do
    post '/calc.rss', params: { arr: '1 2 5 4 5 6 1' }
    response1 = @response.body.clone

    post '/calc.rss', params: { arr: '5 2 7 28 625 1 5 25' }
    response2 = @response.body.clone

    assert_not_equal response1, response2
  end
end
