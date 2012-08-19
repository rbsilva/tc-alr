# encoding: utf-8
class User < ActiveRecord::Base
  has_and_belongs_to_many :roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :role_ids, :user, :delete_flag, :active_flag

  validates :full_name, :presence => true,
            :length => {:minimum => 2}

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def activate
    self.update_attributes(:active_flag => 1)
  end

  def deactivate
    self.update_attributes(:active_flag => 0)
  end

  def logical_destroy
    self.update_attributes(:delete_flag => 1)
  end

  def logical_undestroy
    self.update_attributes(:delete_flag => 0)
  end
end
