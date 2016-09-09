class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists? && (!record.private? || record.user == user || user.admin?)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "You must be logged in to do that." unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
