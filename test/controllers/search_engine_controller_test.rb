require 'test_helper'

class SearchEngineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post index_path
    assert_response :success
  end

  test "should get search" do
    get search_path
    assert_response :success
  end

  # test 'can get data posted to index endpoint' do
  #   post index_path, params: {
  #     page_id: 10,
  #     content: "Elementary, my dear Watson"
  #   }
  # end

end
