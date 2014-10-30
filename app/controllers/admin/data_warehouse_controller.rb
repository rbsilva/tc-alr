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
    result = DataWarehouse.load(params[:load_data], params[:fact])

    logger.fatal result

    begin
      respond_to do |format|
        if result then
          format.json { render json: [I18n.t(:success)], :status =>  :created }
        else
          format.json { render json: [I18n.t(:invalid_operation)], :status =>  :unprocessable_entity }
        end
      end
    rescue
      logger.fatal $!
    end
  end

end
