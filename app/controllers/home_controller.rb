class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @courses = Course.all.limit(3)
    @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
    @latest = Course.latest
    @top_rated = Course.top_rated
    @popular = Course.popular
    @purchased_courses = Course.joins(:enrollments).where(enrollments: { user: current_user }).order(created_at: :desc).limit(3)
  end

  def activity
    if current_user.has_role?(:admin)
      @activities = PublicActivity::Activity.all
    else
      redirect_to root_path, alert: 'You are not authorize to access this page!'
    end
  end

  def analytics
    if current_user.has_role?(:admin)
      #@users = User.all
      #@enrollments = Enrollment.all
      @courses = Course.all
    else
      redirect_to root_path, alert: 'You are not authorize to access this page!'
    end
  end
end
