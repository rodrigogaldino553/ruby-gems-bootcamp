class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  def to_s
    title
  end

  has_rich_text :description
end
