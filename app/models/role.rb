# encoding: utf-8
# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  models     :string(255)
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :models

  validates :name, :presence => true,
            :length => {:minimum => 2}

  def models=(value)
    write_attribute(:models, value.join(','))
  end
end
