class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  def to_s
    title
  end

  has_rich_text :description
end
