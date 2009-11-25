class HelloController < ApplicationController

  def index
    #@recent = Paste.find(:all, :order => "created_at", :limit => 10, :conditions => [ "LENGTH(paste) > 0" ] )
  end

end
