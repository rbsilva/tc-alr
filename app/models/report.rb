class Report < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :fields, :user
end
