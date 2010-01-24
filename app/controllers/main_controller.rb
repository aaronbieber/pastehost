class MainController < ApplicationController
  #skip_before_filter :set_format, :only => [:paste]

	def view
    logger.info "VIEW"
    logger.info request.format
    if not has_code
      redirect_to :controller => 'hello'
    else
      @paste = Paste.find(:first, :conditions => [ "code = ?", params[:code] ])
    end
	end

  def paste
    @preview = false
    @paste = Paste.new

    if request.post?
      @paste = Paste.new(params[:paste])

      if params.has_key?(:commit) and params[:commit] == 'Save'
        @paste.setup
        @paste.ip = request.remote_ip
        if @paste.valid?
          @paste.save
          redirect_to :controller => 'main', :action => 'view', :code => @paste.code
        end
      else
        @preview = true
      end
    end

    respond_to do |format|
      format.html
      format.iphone
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
