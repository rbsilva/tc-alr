class Fact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :columns

  validates :name, :presence => true,
            :length => {:minimum => 2}

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
    ActiveRecord::Base.connection.execute("CREATE TABLE #{name}_fact (id int(11) PRIMARY KEY AUTO_INCREMENT)")
    true
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
    false
  end
end
