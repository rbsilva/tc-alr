class Admin::DashboardController < BaseController
  def index
    @facts = DataWarehouse.facts
  end
end
