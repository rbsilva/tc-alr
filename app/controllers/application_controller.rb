class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, :with => :handle_exceptions

  private
    def handle_exceptions(exception)
      if exception.class == CanCan::AccessDenied then
        flash[:error] = exception.message
        logger.fatal exception.message
        redirect_to root_url
      else
        logger.fatal "AQUI MANO, PEGA! --> #{exception} #{exception.backtrace}"
        #ErrorMailer.notify_error(exception, params).deliver
        #render 'error_mailer/500', :status => 500, :locals => {:error => exception}
        flash[:error] = exception.message
        if request.referer then
          redirect_to request.referer
        else
          redirect_to root_url
        end
      end
    end
end
