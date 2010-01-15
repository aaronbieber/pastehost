# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_format
  layout :get_application

  def render_view_for(template, formats)
    formats.each do |format|
      logger.info File.join(RAILS_ROOT, 'app/views', template + '.' + format.to_s + '.erb')
      if File.exists?(File.join(RAILS_ROOT, 'app/views/', template + '.' + format.to_s + '.erb'))
        render :template => File.join(template + '.' + format.to_s + '.erb')
      end
    end
  end

  private
  MOBILE_BROWSERS = [
    "android",                  "ipod",
    "opera mini",               "blackberry",
    "palm",                     "hiptop",
    "avantgo",                  "plucker",
    "xiino",                    "blazer",
    "elaine",                   "windows ce; ppc;",
    "windows ce; smartphone;",  "windows ce; iemobile",
    "up.browser",               "up.link",
    "mmp",                      "symbian",
    "smartphone",               "midp",
    "wap",                      "vodafone",
    "o2",                       "pocket",
    "kindle",                   "mobile",
    "pda",                      "psp",
    "treo"
  ]

  def set_format
    request.format = get_browser_format
  end

  def get_application
    (get_browser_format == 'html') ? 'application' : get_browser_format + '_application'
  end

  def get_browser_format
    # Force it for now.
    return "iphone"

    agent = request.headers["HTTP_USER_AGENT"].downcase

    # Check for iPhones first
    return "iphone" if agent =~ /iphone/i

    # Otherwise, check for all mobile user agents
    MOBILE_BROWSERS.each do |m|
      return "mobile" if agent.match(m)
    end

    return "html"
  end
end
