class Admin::DashboardController < BaseController
  def index
    @facts = DataWarehouse.facts
    @inbounds = Inbound.all
    begin
      respond_to do |format|
        format.html
      end
    rescue
      logger.fatal $!
    end
  end
end
