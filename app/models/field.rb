﻿# encoding: utf-8
class Field < ActiveRecord::Base
  belongs_to :data_table
  
  attr_accessible :db_type, :description, :is_null
  
  validates :description, :presence => true,
        :length => {:minimum => 2},
        :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}
  
  def description=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    _description = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
    write_attribute(:description, _description)
  end
end
