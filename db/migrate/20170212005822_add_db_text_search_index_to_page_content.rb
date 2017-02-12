class AddDbTextSearchIndexToPageContent < ActiveRecord::Migration[5.0]
  def change
    DbTextSearch::FullText.add_index connection, :page_contents, :content
  end
end
