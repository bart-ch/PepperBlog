class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate([params[:session][:password]])
      redirect_to articles_path
    else
      flash.now[:notice] = "Invalid credentials"
      render 'new'
    end
  end

  def destroy
  end
end