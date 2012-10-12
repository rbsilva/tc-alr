class Admin::DashboardController < BaseController
  def index
    @facts = DataWarehouse.facts
    @inbounds = Inbound.all
  end
end
