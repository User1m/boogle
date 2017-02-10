module SearchEngineHelper
  def log (data)
    puts "Claudius Logging;\n\n#{data.inspect}\n\n"
  end

  def save_page_content(params)
    page = PageContent.new(page_id: params[:page_id], content: params[:content])
    page.save
  end

  # def escape(query)
  #   URI::escape(query.downcase)
  # end 

  def remove_punctuation(string)
    string.gsub(/\W/, ' ')
  end
end
