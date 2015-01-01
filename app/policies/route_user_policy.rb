class RouteUserPolicy < ApplicationPolicy
  def create?
     user == record.user
  end

  def destroy?
    user == record.user
  end

  def edit?
    user == record.user
  end

  def update?
    user == record.user
  end
end
