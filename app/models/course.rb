class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true

  belongs_to :user

  def to_s
    title
  end

  has_rich_text :description


  extend FriendlyId
  friendly_id :title, use: :slugged

  LANGUAGES = [:"English", :"Polish", :"Portuguese", :"Russian", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"Beginner", :"Intermediated", :"Advanced", :"N/A"]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end
end
