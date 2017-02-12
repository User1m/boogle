class PageContent < ApplicationRecord
  validates_presence_of :page_id
  validates :content, presence: true, length: {maximum: 255}
  before_save :downcase_and_pad_content

  private
  def downcase_and_pad_content
    self.content = " #{self.content.downcase!} "
  end
end
