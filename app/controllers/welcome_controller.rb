class WelcomeController < ApplicationController
  def index
    flash[:warning] = "小心 warning 信息！"
  end
end
