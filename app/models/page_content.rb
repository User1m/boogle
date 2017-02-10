class PageContent < ApplicationRecord
  validates_presence_of :page_id
  validates :content, presence: true, length: {maximum: 255}
  before_save {content.downcase!}
end
