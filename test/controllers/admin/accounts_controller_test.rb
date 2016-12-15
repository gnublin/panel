require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest

  include FactoryGirl::Syntax::Methods

  def setup
    @user = create :user
    @user_admin = create :user_admin
  end

  def test_index_accounts_unauthorized_user
    sign_in @user

    get admin_accounts_url
    assert_redirected_to root_path
  end

  def test_index_accounts
    sign_in @user_admin

    get admin_accounts_url
    assert_response :ok
  end

  def test_show_account
    sign_in @user_admin

    get admin_account_url(@user.id)
    assert_response :ok
  end

  def test_new_account
  end

  def test_edit_account
    sign_in @user_admin

    get edit_admin_account_url(@user)
    assert_response :ok
  end

  def test_create_account
  end

  def test_update_account
    sign_in @user_admin

    post admin_accounts_url, params: {user: {email: 'ohohoh@christ.mas', admin: false}}
    assert_response :ok
  end

  def test_destroy_account
    sign_in @user_admin

    delete admin_account_url(@user)
    assert_response :ok
  end


end
