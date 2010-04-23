# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include SimpleCaptcha::ControllerHelpers

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  rescue_from ActionController::RoutingError, :with => :not_found #404
  rescue_from ActionController::UnknownAction, :with => :no_action_found #501
  
protected
  def not_found
    render :template => 'errors/404', :status => 404
  end
  def no_action_found
    render :template => 'errors/501', :status => 501
  end
end

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  %(<font style="color:red"> *Required</font>) + html_tag
end
