# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_format

  def set_format
    request.format = :iphone if iphone_request?
  end

  def iphone_request?
    return (request.subdomains.first == 'iphone' || params[:format] == 'iphone')
  end
end
