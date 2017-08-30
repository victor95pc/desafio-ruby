class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Product
    can :read, Store

    if user.admin? || user.store_owner?
      can :manage, :all
    end
  end
end
