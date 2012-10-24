class DwDb < ActiveRecord::Base
  establish_connection :data_warehouse

  self.abstract_class = true
end
