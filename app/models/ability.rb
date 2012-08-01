class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    elsif user.role? :product_admin
      can :manage, [Product, Asset, Issue]
    elsif user.role? :product_team
      can :read, [Product, Asset]
      can :manage, Product do |product|
        product.try(:owner) == user
      end
      can :manage, Asset do |asset|
        asset.assetable.try(:owner) == user
      end
    end

  end
end
