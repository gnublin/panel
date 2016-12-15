class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_is_an_admin

  private
  def user_is_an_admin
    @is_an_admin = false
    if current_user && current_user.admin
      @is_an_admin = true
    end
  end
end
