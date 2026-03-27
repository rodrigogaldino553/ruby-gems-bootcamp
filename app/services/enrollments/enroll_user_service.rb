module Enrollments
  class EnrollUserService
    attr_reader :user, :course, :price, :enrollment, :script_token

    def initialize(user, course, script_token)
      @user = user
      @course = course
      @price = course.price
      @script_token = script_token
    end

    def call
      ActiveRecord::Base.transaction do
        enroll_user
        Enrollments::SyncBalanceService.new(enrollment).call
      end

      notify_users
      {success: true}
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Enrollment failed: #{e.message}")
      {success: false, error_message: e.message}
    rescue Stripe::CardError => e
      Rails.logger.error("Enrollment failed: #{e.message}")
      {success: false, error_message: e.message}
    end

    private

    def enroll_user
      stripe_transaction if price > 0
      @enrollment = course.enrollments.create!(user: user, price: price)
    end

    def stripe_transaction
      customer = Stripe::Customer.create(
        email: user.email,
        source: script_token
      )
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: (course.price * 100).to_i,
        description: course.title,
        currency: "usd"
      )
    end

    def notify_users
      EnrollmentMailer.student_enrollment(enrollment).deliver_later
      EnrollmentMailer.teatcher_enrollment(enrollment).deliver_later
    end
  end
end
