class TrailPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

    def index?
      true
    end

    def new?
      true
    end

    def create?
      true
    end

    def edit?
      owner_or_admin?
    end

    def update?
      owner_or_admin?
    end

    def destroy?
      owner_or_admin?
    end

    def show?
      true
    end

    def owner_or_admin?
      record.user == user || user.admin
    end

end
