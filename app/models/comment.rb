class Comment < ApplicationRecord

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true
  validates :content, presence: true

  def to_s
    self.content
  end
end