class Dimension
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :columns

  validates :name, :presence => true,
            :length => {:minimum => 2}


  def self.all
    dimensions = []
    all = ActiveRecord::Base.connection.tables.grep(/.*_dimension$/)
    all.each {|table| dimensions << Dimension.new(:name => table.scan(/(.*)_dimension$/).last.first)}
    dimensions
  end

  def self.find(id)
    result = ActiveRecord::Base.connection.tables.grep(/^#{id}_dimension$/)[0]

    if result.nil? then
      raise 'Dimension not found'
    else
      Dimension.new(:name => result.scan(/(.*)_dimension$/).last.first)
    end
  end

  def save
    ActiveRecord::Base.connection.execute("CREATE TABLE #{name}_dimension (id int(11) PRIMARY KEY AUTO_INCREMENT)")
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
    ActiveRecord::Base.connection.execute("DROP TABLE #{name}_dimension")
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
