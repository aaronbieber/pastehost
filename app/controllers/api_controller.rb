class ApiController < ApplicationController

	def paste
		if !params[:p].nil? and !params[:p].empty?
			text = params[:p]
			if !params[:u].nil? and !params[:u].empty?
				text += "\n\nPasted from "+params[:u]
			end
			p = Paste.new({ :paste => text })
			p.setup
      p.ip = request.remote_ip
			if p.valid?
				p.save
				redirect_to :controller => 'main', :action => 'view', :code => p.code
			end
		end
	end

end
