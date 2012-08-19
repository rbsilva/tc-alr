class Ability
  include CanCan::Ability

  def initialize(user)
  begin
    user ||= User.new # guest user

    user.roles.each do |role|
      if role.name.to_sym == :admin
        can :manage, :all
      elsif !role.models.nil?
        role.models.split(',').each do |model|
          can :manage, eval(model.camelize)
        end
      end
    end
  end
  rescue => e
   log e
  end
end
