class Admin::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]

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
      p @user
      p params
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
      # unless current_user.admin
      #   redirect_to "/"
      # end
    end

    def set_users
      @users = User.all
    end

    def set_user
      @user = User.find(params[:id])
      # @site = Site.where(id: params[:id], user_id: current_user.id)
    end

    def user_params
      p params
      params.require(:email).permit(:admin)
    end

end
