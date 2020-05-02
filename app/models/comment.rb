class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :content, presence: true, allow_blank: false

  has_rich_text :content

end
