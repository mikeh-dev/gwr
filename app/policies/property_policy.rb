class PropertyPolicy < ApplicationPolicy
    def create?
      user.role == 'landlord' || user.admin?
    end
  
    def show?
     user.landlord? || user.tenant? && record.current_tenant == user || user.admin?
    end
  
    def index?
      user.landlord? || user.admin?
    end
  
    def update?
      user.admin? || user.landlord? && record.landlord == user
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
          scope.joins(:agreements).where(agreements: { tenant: user })
        else
          scope.none
        end
      end
    end
  end