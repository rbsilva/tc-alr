class DataWarehouseDb < ActiveRecord::Base
  establish_connection "data_warehouse_#{Rails.env}"

  self.abstract_class = true
end
