class DataWarehouse
  def self.facts
    DataTable.where(:fact => true)
  end

  def self.load(data)
    facts = {}

    data.each do |datum|
      splitted = eval(datum)

      id = splitted[0]
      field_id = splitted[1]
      value = splitted[2]

      if facts[id].nil? then
        facts.store(id, [[field_id, value]])
      else
        facts[id] << [field_id, value]
      end
    end

    facts.each_pair do |id, rows|
      table = nil
      fact = nil

      rows.each do |field|
        _field = Field.find(field.first)
        if _field.data_table.fact then
          table = _field.data_table
          fact = eval(table.name.camelize).new
          break
        end
      end

      rows.each do |field|
        _field = Field.find(field.first)

        if _field.data_table != table then
          dimension = _field.data_table.name

          if fact.send(dimension.to_sym).nil? then
            fact.send("#{dimension.to_sym}=", eval(dimension.camelize).new)
          end

          fact.send(dimension.to_sym).send("#{_field.description}=".to_sym, field.last)
        else
          fact.send("#{_field.description}=".to_sym, field.last)
        end
      end

      fact.save
    end

    true
  rescue
    $!
  end
end
