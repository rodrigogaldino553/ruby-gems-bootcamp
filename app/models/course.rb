class Course < ApplicationRecord
  extend FriendlyId
  include PublicActivity::Model

  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_many :course_tags, dependent: :destroy
  has_many :tags, through: :course_tags
  has_rich_text :description
  has_one_attached :avatar

  validates :title, uniqueness: true, length: { maximum: 70 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :description, length: { minimum: 5 }
  validates :short_description, length: { maximum: 300 }
  validates :avatar, presence: true, on: :update
  validates :avatar,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 500.kilobytes, message: 'size should be under 500kb!' }

  scope :latest, ->  { limit(3).order(created_at: :desc) }
  scope :top_rated, ->  { limit(3).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }


  friendly_id :title, use: :slugged
  tracked owner: Proc.new{ |controller, model| controller.current_user }


  LANGUAGES = [:"English", :"Polish", :"Portuguese", :"Russian", :"Spanish"]
  LEVELS = [:"Beginner", :"Intermediated", :"Advanced", :"N/A"]

  def to_s
    title
  end

  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  def self.ransackable_attributes(auth_object = nil)
    ["approved", "average_rating", "created_at", "description", "enrollments_count", 
     "id", "language", "lessons_count", "level", "price", "published", 
     "short_description", "slug", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    # Add any associations you want searchable, or leave empty if none
    []
  end

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end

  def progress(user)
    unless self.lessons.count.zero?
      user_lessons.where(user: user).count/self.lessons_count.to_f*100
    end
  end

  def update_rating
    if enrollments.any? || enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
end
