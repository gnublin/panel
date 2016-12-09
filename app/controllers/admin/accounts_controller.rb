class Admin::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:index, :show]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    p "dd"
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_account_path, notice: "Account up to date" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

    def is_admin
      unless current_user.admin
        redirect_to "/"
      end
    end

    def set_users
      @users = User.all
    end

    def set_user
      @user = User.find(params[:id])
      # @site = Site.where(id: params[:id], user_id: current_user.id)
    end

    def user_params
      params.require(:user).permit(:email, :admin)
    end
end
