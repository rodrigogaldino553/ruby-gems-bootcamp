class Courses::CourseWizardController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: [:show, :update]
  before_action :set_course, only: [:show, :update, :finish_wizard_path]

  steps :basic_info, :details, :publish

  def show
    authorize @course, :edit?
    @tags = Tag.all
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :publish
    end
    render_wizard
  end

  def update
    authorize @course, :edit?
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :publish
    end
    @course.update(course_params)
    render_wizard @course
  end

  def finish_wizard_path
    authorize @course, :edit?
    course_path(@course)
  end

  private
    def set_progress
      if wizard_steps.any? && wizard_steps.index(step).present?
        @progress = ((wizard_steps.index(step) +1).to_d / wizard_steps.count.to_d) * 100
      else
        @progress = 0
      end
    end

    def set_course
      @course = Course.friendly.find params[:course_id]
    end

    def course_params
      params.require(:course).permit(:title, :avatar, :description, :short_description, :published, :price, :language, :level, tag_ids: [])
    end
end
