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
      raise 'Fact not found'
    else
      Fact.new(:name => result.scan(/(.*)_fact$/).last.first)
    end
  end

  def save
    if valid? then
      sql = "CREATE TABLE #{name}_fact ( id int(11) PRIMARY KEY AUTO_INCREMENT"
      @columns.each do |column|
        meta = column.split(':')
        sql += ',' + meta[0] + ' ' + meta[1] + ' ' + (meta[2] == 1 ? 'NOT NULL' : '')
      end
      
      @foreign_keys.each do |column|
        meta = column.split(':')
        sql += ',' + meta[0] + ' int(11) '
        sql += ', FOREIGN KEY (' + meta[0] + ') REFERENCES '+ meta[1] +'_dimension(id)'
      end
      
      sql += ')' 
      ActiveRecord::Base.connection.execute(sql)
      true
    end
  rescue
    errors.add(:name, $!)
    false
  end

  def update_attributes(attributes = {})
    errors.add(:name, $!)
    false
  end

  def destroy
    ActiveRecord::Base.connection.execute("DROP TABLE #{name}_fact")
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
