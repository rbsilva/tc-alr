# encoding: utf-8
class Fact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :columns, :foreign_keys

  validates :name, :presence => true,
            :length => {:minimum => 2},
            :format => { :with => /^[A-z_ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖòóôõöÈÉÊËèéêëðÇçÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž].*$/}
  validates :columns, :presence => true,
            :length => {:minimum => 2}
  validates :foreign_keys, :presence => true,
            :length => {:minimum => 2}

  def columns
    @columns.join(',') unless @columns.nil?
  end

  def columns=(value)
    @columns = value.gsub(/\s+/, "").split(',')
  end

  def id
    @name
  end

  def name=(value)
    # primeiro gsub substitui espaços por '_' e o segundo gsub apaga qualquer símbolo
    @name = value.strip.downcase.gsub(/\s+/, '_').sub_accents.gsub(/[^A-z0-9_]+/,'')
  end

  #def foreign_keys
  #  @foreign_keys.join(',') unless @foreign_keys.nil?
  #end

  def foreign_keys=(value)
    @foreign_keys = value.gsub(/\s+/, "").split(',')
  end

  def self.all
    facts = []
    all = ActiveRecord::Base.connection.tables.grep(/.*_fact$/)
    all.each {|table| facts << Fact.new(:name => table.scan(/(.*)_fact$/).last.first)}
    facts
  end

  def self.find(id)
    result = ActiveRecord::Base.connection.tables.grep(/^#{id}_fact$/)[0]

    if result.nil? then
      raise I18.t(:fact_not_found)
    else
      DataWarehouse.find_table 'fact', id
    end
  end

  def save
    if valid? then
      sql = "CREATE SEQUENCE #{name}_fact_seq START 1"
      ActiveRecord::Base.connection.execute(sql)
      sql = "CREATE TABLE #{name}_fact ( id integer PRIMARY KEY DEFAULT nextval('#{name}_fact_seq')"
      @columns.each do |column|
        meta = column.split(':')
        sql += ',' + meta[0] + ' ' + meta[1] + ' ' + (meta[2] == 1 ? 'NOT NULL' : '')
      end

      @foreign_keys.each do |column|
        sql += ',' + column + '_id integer '
        sql += ', FOREIGN KEY (' + column + '_id) REFERENCES '+ column +'_dimension(id)'
      end

      sql += ')'
      ActiveRecord::Base.connection.execute(sql)
      true
    end
  rescue
    ActiveRecord::Base.connection.execute("DROP SEQUENCE #{name}_fact_seq")
    errors.add(:name, $!)
    false
  end

  def update_attributes(attributes = {})
    errors.add(:name, $!)
    false
  end

  def destroy
    ActiveRecord::Base.connection.execute("DROP TABLE #{name}_fact")
    ActiveRecord::Base.connection.execute("DROP SEQUENCE #{name}_fact_seq")
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    result = ActiveRecord::Base.connection.tables.grep(/^#{@name}_fact$/)[0]

    if result.nil? then
      false
    else
      true
    end
  end
end
