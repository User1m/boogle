require 'test_helper'
require 'search_engine_helper'

class SearchEngineControllerTest < ActionDispatch::IntegrationTest
  include AssertJson
  test "post to index with no data return 404 " do
    post index_path
    assert_response 400
  end

  test "should get search" do
    get search_path
    assert_response 404
  end

  test 'can post data to index endpoint with valid data' do
    post_to_index
    assert_response 204 
  end

  test 'can save posted data to database' do
    assert_difference 'PageContent.count', 1 do
      post_to_index
    end
  end

  test 'posted errors should return 404 with errors' do
    assert_no_difference 'PageContent.count' do
      post index_path, params: {
        page_id: 10,
      }
    end
    assert_response 400
  end

  test 'search rejects non-permitted params' do
    get search_path, params: {test: "hello world"}
    assert_response 404
  end

  test 'search allows only permitted params' do
    get search_path, params: {query: "hello world"}
    assert_response :success
  end

  test 'search without query params should return empty matches array' do
    get search_path, params: {query: " "}
    assert_json @response.body  do
      has :matches, []
    end
  end

  test 'search query returns matches' do
    get search_path, params: {query: "Elementary, my dear Watson"}
    log(@response.body)
    assert_json @response.body  do
      has :matches do 
        has :page_id
        # has :score
      end
    end
  end

end
