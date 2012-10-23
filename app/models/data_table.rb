# encoding: utf-8
class DataTable < ActiveRecord::Base
  require 'rails/generators'
  
  belongs_to :user
  has_many :fields
  
  accepts_nested_attributes_for :fields, :reject_if => proc { |attributes| attributes['description'].blank? }, :allow_destroy => true
  
  attr_accessible :user_id, :name, :fact, :fields_attributes
  
  after_save :generate_model
  
  validates :name, :presence => true,
          :length => {:minimum => 2},
          :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}
          
  def name=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    _name = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
    write_attribute(:name, _name)
  end
  
  private
    def generate_model
      args = [name]
      fields.each do |field|
        args << "#{field.description}:#{field.db_type}"
      end
      args << '--migration=true'
      args << '--timestamps=true'
      Rails::Generators.invoke('active_record:model', args)
    end
end
