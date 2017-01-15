class Admin::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_non_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:index, :show]

  def index
     @users = params[:admin] == 'true' ? User.where(admin: true) : User.all
     @users = @users.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_account_path(@user), notice: "user #{@user['email']} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_accounts_path, notice: "Account unlock" } if Rails.application.routes.recognize_path(request.referrer)[:action] == 'index'
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

    def reject_non_admin
      redirect_to "/", flash: {danger: 'You are not allowed to see this page.'} unless user_admin?
    end

    def set_users
      @users = User.all
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if params[:user][:password].nil? || params[:user][:password].empty?
        params[:user].delete "password"
        params[:user].delete "password_confirmation"
      end
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :locked_at, :failed_attempts)
    end
end
