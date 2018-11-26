class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: user_pwd_email_param)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
  def update
    
  end

  private

  def user_pwd_email_param
    params[:password_reset][:email].downcase!
  end
end
