# encoding: utf-8
class Field < ActiveRecord::Base
  belongs_to :data_table

  before_save :set_description_suffix

  attr_accessible :db_type, :description, :is_null

  validates :description, :presence => true,
        :length => {:minimum => 2},
        :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}

  DB_TYPE = %w(binary boolean date datetime decimal float integer primary_key string text time timestamp references)

  def description=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    _description = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
    write_attribute(:description, _description)
  end

  private
    def set_description_suffix
      if db_type == 'references' then
        _description = description
        _description += '_dimensions'
        write_attribute(:description, _description)
      end
    end
end
