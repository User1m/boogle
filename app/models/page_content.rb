class PageContent < ApplicationRecord
  validates_presence_of :page_id
  validates :content, presence: true, length: {maximum: 255}
  before_save :pad_content

  private
  def pad_content
    self.content = " #{self.content} "
  end
end
