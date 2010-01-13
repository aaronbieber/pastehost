# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  # session :session_key => '_pastehost_session_id'
  layout :detect_browser

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

  def detect_browser
    # Force it for now.
    return "mobile_application"

    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "mobile_application" if agent.match(m)
    end

    return "application"
  end
end
