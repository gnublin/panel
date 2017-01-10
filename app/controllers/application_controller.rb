class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :user_admin?

  private

  def user_admin?
    current_user && current_user.admin
  end
end
