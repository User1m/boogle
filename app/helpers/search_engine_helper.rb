module SearchEngineHelper
  def log (data)
    puts "Claudius Logging;\n\n#{data.inspect}\n\n"
  end

  def save_page_content(params)
    page = PageContent.new(page_id: params[:page_id], content: strip_downcase_and_remove_punctuation(params[:content]))
    page.save
  end

  # def escape(query)
  #   URI::escape(query.downcase)
  # end 

  def strip_downcase_and_remove_punctuation(string)
    string ? string.downcase.gsub(/\W/, ' ').strip : nil
  end
  
end
