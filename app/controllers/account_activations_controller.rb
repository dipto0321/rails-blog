# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    # debugger
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      sign_in @user
      flash[:success] = 'Account activated!'
      redirect_to @user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end

  private

  def user_email; end
end
