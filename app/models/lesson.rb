class Lesson < ApplicationRecord
  extend FriendlyId
  include PublicActivity::Model
  include RankedModel

  belongs_to :course, counter_cache: true
  has_many :comments, dependent: :nullify
  has_many :user_lessons, dependent: :destroy
  has_rich_text :content
  has_one_attached :video
  has_one_attached :video_thumbnail

  validates :title, :content, :course,  presence: true
  validates :title, length: { maximum: 70 }
  validates_uniqueness_of :title, scope: :course_id
  validates :video,
    content_type: ['video/mp4'],
    size: { less_than: 50.megabytes, message: 'size shuld be under 50MB!' }

  validates :video_thumbnail,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 500.kilobytes, message: 'size shuld be under 500kb!' }


  friendly_id :title, use: :slugged
  tracked owner: Proc.new{ |controller, model| controller.current_user }
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
