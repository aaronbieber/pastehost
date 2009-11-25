class MainController < ApplicationController

	def view
    if not has_code
      redirect_to :controller => 'hello'
    else
      @paste = Paste.find(:first, :conditions => [ "code = ?", params[:code] ])
    end
	end

  def paste
    @paste = Paste.new

    if request.post?
      @paste = Paste.new(params[:paste])
      @paste.setup
      @paste.ip = request.remote_ip
      if @paste.valid?
        @paste.save
        redirect_to :controller => 'main', :action => 'view', :code => @paste.code
      end
    end
  end

  def random
    @paste = Paste.random
    redirect_to :action => 'view', :code => @paste.code
  end

  def has_code
    !params[:code].blank?
  end
end
