# encoding: utf-8
class Field < ActiveRecord::Base
  belongs_to :table
  
  attr_accessible :type, :description, :is_null
  
  validates :description, :presence => true,
        :length => {:minimum => 2},
        :format => { :with => /^[A-z_���������������������������������������������������񊚟����].*$/}
  
  def description=(value)
    # primeiro gsub substitui espa�os por '_' e o segundo gsub apaga qualquer s�mbolo
    @name = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
  end
end
