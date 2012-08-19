# encoding: utf-8
class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :models

  validates :name, :presence => true,
            :length => {:minimum => 2}

  def models=(value)
    write_attribute(:models, value.join(','))
  end
end
