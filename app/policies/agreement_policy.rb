class AgreementPolicy < ApplicationPolicy
  def create?
    user.role == 'landlord' || user.admin?
  end

  def show?
    user == record.landlord || user == record.tenant || user.admin?
  end

  def index?
    user.landlord? || user.tenant? || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.landlord?
        scope.where(landlord: user)
      elsif user.tenant?
        scope.where(tenant: user)
      else
        scope.none
      end
    end
  end
end