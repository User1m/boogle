require 'test_helper'

class PageContentTest < ActiveSupport::TestCase
  def setup
    @page = PageContent.new(page_id: 300, content: "Hello")
  end

  test "page_id is present" do
    @page.page_id =  nil
    assert_not @page.valid?  
  end

  test "content is present" do
    @page.content =  nil
    assert_not @page.valid?  
  end

  test 'page is valid' do
    assert @page.valid?
  end

  test 'content length is within limit' do 
    @page.content = 'a'*300
    assert_not @page.valid?
  end

  test 'content is downcased before save' do
    content = "Elementary, my dear Watson"
    @page.content = content
    @page.save
    assert_equal content.downcase, @page.content
  end

end
