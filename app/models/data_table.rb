﻿# encoding: utf-8
class DataTable < ActiveRecord::Base
  require 'rails/generators'
  require 'fileutils'

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
    _name += fact ? '_fact' : '_dimension'
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
    def generate_model
      args = ["#{name}"]

      fields.each do |field|
        args << "#{field.description}:#{field.db_type}"
      end

      args << '--migration=true'
      args << '--timestamps=true'
      args << '--force'

      result = Rails::Generators.invoke('active_record:model', args)

      migration_file = result[2]

      #workaround for generate migrations with parent option
      args << '--parent=DwDb'
      result = Rails::Generators.invoke('active_record:model', args)

      model_file = result[3]

      dw_migrate_folder = File.join Rails.root, "db/dw_migrate/#{File.basename(migration_file)}"
      dw_models_folder = File.join Rails.root, "app/dw_models/#{File.basename(model_file)}"

      FileUtils.mv(migration_file, dw_migrate_folder)
      FileUtils.mv(model_file, dw_models_folder)
    end
end
