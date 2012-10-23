# encoding: utf-8
class DataTable < ActiveRecord::Base
  belongs_to :user
  has_many :fields
  
  accepts_nested_attributes_for :fields, :reject_if => proc { |attributes| attributes['name'].blank? }, :allow_destroy => true
  
  attr_accessible :user_id, :name, :fact
  
  validates :name, :presence => true,
          :length => {:minimum => 2},
          :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}
          
  def name=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    _name = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
    write_attribute(:name, _name)
  end
end
