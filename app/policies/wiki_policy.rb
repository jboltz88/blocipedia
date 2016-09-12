class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    Wiki.where(:id => record.id).exists? && (!record.private? || record.user == user || user.admin?)
  end

  def create?
    user.present?
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
    user.admin? || record.user == user
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
      wikis = []
      if user.role == 'admin'
        wikis = scope.all #show admins all wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki #for premium users, show all public wikis and private wikis they either created or are a collaborator for
          end
        end
      else #standard users
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.include?(user)
            wikis << wiki #only show public wikis and wikis they are collaborators for
          end
        end
      end
      wikis #return the wikis array
    end
  end
end
