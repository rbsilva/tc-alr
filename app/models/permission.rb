class Permission < ActiveRecord::Base
  attr_accessible :description, :path
  has_and_belongs_to_many :users
end
