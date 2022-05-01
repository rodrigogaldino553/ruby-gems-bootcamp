class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  has_many :comments, dependent: :nullify
  # Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
  validates :title, :content, :course,  presence: true
  validates :title, length: { maximum: 70 }
  validates_uniqueness_of :title, scope: :course_id

  has_rich_text :content
  has_one_attached :video
  has_one_attached :video_thumbnail

  validates :video,
    content_type: ['video/mp4'],
    size: { less_than: 50.megabytes, message: 'size shuld be under 50MB!' }

  validates :video_thumbnail,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 500.kilobytes, message: 'size shuld be under 500kb!' }
  # validates :video_thumbnail, presence: true, if: :video_present?
  # def video_present?
  #   self.video.present?
  # end


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
