# encoding: utf-8
class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_many                :raw_files

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :role_ids

  validates :full_name, :presence => true,
            :length => {:minimum => 2},
            :format => {:with => /^[A-zÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž\s]+$/}

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
