class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end

  def update?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end

  def new?
    @user.has_role? :teacher
  end

  def create?
    @user.has_role? :teacher
  end

  def destroy?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end
end
