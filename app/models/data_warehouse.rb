class DataWarehouse
  def self.facts
    DataTable.where(:fact => true)
  end

  def self.load(data, fact_name)
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
      fact = eval("::#{fact_name.singularize.camelize}").new

      rows.each do |field|
        _field = Field.find(field.first)

        if _field.data_table.name != fact_name then
          dimension = _field.data_table.name

          if fact.send(dimension.singularize.to_sym).nil? then
            fact.send("#{dimension.singularize.to_sym}=", eval("::#{dimension.singularize.camelize}").new)
          end

          fact.send(dimension.singularize.to_sym).send("#{_field.description}=".to_sym, field.last)
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
