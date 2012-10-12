# encoding: UTF-8
class Admin::InboundController < BaseController

  def index
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
