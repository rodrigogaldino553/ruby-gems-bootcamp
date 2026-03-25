class Comment < ApplicationRecord
  include PublicActivity::Model

  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true
  
  validates :content, presence: true

  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    self.content
  end
end