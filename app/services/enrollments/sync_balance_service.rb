module Enrollments
  class SyncBalanceService
    attr_reader :user, :course, :price

    def initialize(enrollment)
      @user = enrollment.user
      @course = enrollment.course
      @price = course.price
    end

    def call
      ActiveRecord::Base.transaction do
        sync_course_income
        sync_user_balance
      end
    
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Failed to sync balance for enrollments #{e.message}")
      false
    end

    private

    def sync_course_income
      course.update_column(:income, course.enrollments.sum(:price))
      course_owner = course.user
      course_income = course_owner.courses.sum(:income)
      course_owner.update_columns(
        course_income: course_income,
        balance: course_income - course_owner.enrollment_expenses
      )
    end

    def sync_user_balance
      enrollment_expenses = user.enrollments.sum(:price)
      user.update_columns(
        enrollment_expenses: enrollment_expenses,
        balance: user.course_income - enrollment_expenses
      )
    end
  end
end