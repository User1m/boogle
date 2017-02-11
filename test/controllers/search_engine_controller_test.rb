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
    assert @response.body
    assert_json @response.body do
      has :matches, []
    end
  end

  test 'search query returns matches with pageId and score keys' do
    get search_path, params: {query: "Elementary, my dear Watson"}
    assert_json @response.body do
      has :matches do
        item 0 do
          has :pageId
          has :score
        end
      end
    end
  end

  test 'search query with multiple matches returns matched ordered by score(DESC)' do
    get search_path, params: {query: "Hello World dear"}
    assert_json @response.body do
      has :matches do 
        has_length_of 4
        item 0 do 
          has :score, 3
        end
        item 1 do 
          has :score, 2
        end
        item 2 do 
          has :score, 1
        end
        item 3 do 
          has :score, 1
        end
      end
    end
  end

  test 'search query returns accurate score' do
    get search_path, params: {query: "Elementary, my dear Watson"}
    assert_json @response.body do
      has :matches do 
        has_length_of 2
        item 0 do
          has :score, 4
        end
      end
    end
  end

  test 'search returns all matches in db 1' do
    get search_path, params: {query: "dear Watson"}
    assert_json @response.body do
      has :matches do 
        has_length_of 2
      end
    end
  end

  test 'search returns all matches in db 2' do
    get search_path, params: {query: "my dear Watson"}
    assert_json @response.body do
      has :matches do 
        has_length_of 2
      end
    end
  end

  test 'search returns all matches in db 3' do
    get search_path, params: {query: "quick but lazy brown dog"}
    assert_json @response.body do
      has :matches do 
        has_length_of 1
        item 0 do
          has :score, 4
        end
      end
    end
  end

  test 'search returns all matches in db 4' do
    get search_path, params: {query: "the quick fox"}
    assert_json @response.body do
      has :matches do 
        has_length_of 1
        item 0 do
          has :score, 3
        end
      end
    end
  end

  test 'search returns all matches in db 5' do
    get search_path, params: {query: "the fox"}
    assert_json @response.body do
      has :matches do 
        has_length_of 1
        item 0 do
          has :score, 2
        end
      end
    end
  end

  test 'search returns all matches in db 6' do
    get search_path, params: {query: "the"}
    assert_json @response.body do
      has :matches do 
        has_length_of 1
        item 0 do
          has :score, 1
        end
      end
    end
  end

end
