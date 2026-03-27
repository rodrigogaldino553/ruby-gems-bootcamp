module Enrollments
  class EnrollUserService
    attr_reader :user, :course, :price, :enrollment

    def initialize(user, course)
      @user = user
      @course = course
      @price = course.price
    end

    def call
      ActiveRecord::Base.transaction do
        enroll_user
        Enrollments::SyncBalanceService.new(enrollment).call
      end

      notify_users
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Enrollment failed: #{e.message}")
      false
    end

    private

    def enroll_user
      @enrollment = course.enrollments.create!(user: user, price: price)
    end

    def notify_users
      EnrollmentMailer.student_enrollment(enrollment).deliver_later
      EnrollmentMailer.teatcher_enrollment(enrollment).deliver_later
    end
  end
end
