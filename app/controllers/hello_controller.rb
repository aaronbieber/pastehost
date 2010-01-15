class HelloController < ApplicationController
  skip_before_filter :set_format

  def index
  end

end
