# encoding: utf-8
class DataTable < ActiveRecord::Base
  require 'rails/generators'
  require 'fileutils'

  belongs_to :user
  has_many :fields, :dependent => :destroy

  accepts_nested_attributes_for :fields, :reject_if => proc { |attributes| attributes['description'].blank? }, :allow_destroy => true

  attr_accessible :user_id, :name, :fact, :fields_attributes

  before_save :set_name_suffix
  after_save :generate_model
  before_destroy :drop_table

  validates :name, :presence => true,
          :length => {:minimum => 2},
          :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}

  def name=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    _name = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
    write_attribute(:name, _name)
  end

  def fields_build
    length = fields.length
    count = 10 - length
    count.times do |i|
      fields.build()
    end
  end

  private
    def set_name_suffix
      _name = name
      _name += fact ? '_facts' : '_dimensions'
      write_attribute(:name, _name)
    end

    def drop_table
      DataWarehouseMigrator.drop_table_model(name)
      dw_model = "#{Rails.root}/app/models/data_warehouse/#{name.singularize}.rb"
      FileUtils.rm dw_model
    end

    def generate_model
      DataWarehouseMigrator.create_table_model(name, fields)
      File.open("#{Rails.root}/app/models/data_warehouse/#{name.singularize}.rb", 'w') do |f|
        class_text = "class #{name.singularize.camelize} < DataWarehouseDb"
        fields.each do |field|
          if field.description.end_with? "_dimensions" then
            class_text += "\n  belongs_to :#{field.description.singularize}"
          end
        end
        class_text += "\nend"
        f.write(class_text)
      end
    end
end
