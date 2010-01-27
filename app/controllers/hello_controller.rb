class HelloController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.iphone
    end
  end
end
