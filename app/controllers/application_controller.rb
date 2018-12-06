# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to signin_path
    end
  end
end
