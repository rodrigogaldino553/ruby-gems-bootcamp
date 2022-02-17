class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  # Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
  validates :title, :content, :course,  presence: true

  has_rich_text :content

  has_many :user_lessons, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  include RankedModel
  ranks :row_order, :with_same => :course_id

  def to_s
    title
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
  end

  def prev
    course.lessons.where("row_order < ?", row_order).order(:row_order).last
  end

  def next
    course.lessons.where("row_order > ?", row_order).order(:row_order).first
  end
  
end
