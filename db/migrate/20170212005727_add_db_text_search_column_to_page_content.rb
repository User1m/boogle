class AddDbTextSearchColumnToPageContent < ActiveRecord::Migration[5.0]
  def change
    DbTextSearch::CaseInsensitive.add_ci_text_column connection, :page_contents, :content
  end
end
