class Admin::DataWarehouseController < BaseController

  def index
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

  def load
    result = DataWarehouse.load(params[:fact], params[:load_data], params[:load_header])

    logger.fatal result

    begin
      respond_to do |format|
        format.json { render json: result }
      end
    rescue
      logger.fatal $!
    end
  end

end
