require 'search_engine_helper'

class SearchEngineHelperTest < ActionView::TestCase

  # test 'escapes downcases & URI escapes text' do
  #   result = escape("Elementary, my dear Watson")
  #   assert_equal URI::escape("Elementary, my dear Watson".downcase), result
  # end

  test 'save_page_content saves valid PageContent' do
    assert save_page_content({page_id: 200, content: "hi"})
  end

  test 'strip_downcase_and_remove_punctuation removes all non-alphanumeric chars' do
    str = "Elementary, my dear Watson!"
    result = strip_downcase_and_remove_punctuation(str)
    assert_equal str.downcase.gsub(/\W/, ' ').strip, result
  end

end