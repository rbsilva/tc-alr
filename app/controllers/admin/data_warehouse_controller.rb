class Admin::DataWarehouseController < BaseController

  def list
    @dimensions = DataWarehouse.dimensions
    @facts = DataWarehouse.facts

    begin
      respond_to do |format|
        format.html
      end
    rescue
      logger.fatal $!
    end
  end

end
