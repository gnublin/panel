require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
    @page_1 = create :page, site: @site
  end

  def test_pages_reject_unauthenticated_request
    get site_pages_url(@site.id)
    assert_redirected_to new_user_session_url
  end

  def test_index_pages
    sign_in @site.user
    post site_pages_url(@site), params: {page: {title: 'about', url: 'about', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    post site_pages_url(@site), params: {page: {title: 'about_disable', url: 'about_disable', active: false, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}

    get site_pages_url(@site)
    assert_response :ok
    assert_select 'h1', /Pages of.*/
    assert_select 'a', 'New page'
    assert_select 'a', 'Show only active pages'
  end

  def test_show_page
    sign_in @site.user

    get site_page_url(@site, @page_1)
    assert_response :ok
  end

  def test_new_page
    sign_in @site.user

    get new_site_page_url(@site)
    assert_response :ok
    assert_select 'form'
    assert_select 'form input', 10
    assert_select '[data-disable-with=?]', 'Create Page'
    assert_select 'a', 'Back'
  end

  def test_edit_page
    sign_in @site.user

    get edit_site_page_url(@site, @page_1)
    assert :ok
    assert_select 'form'
    assert_select 'form input', 11
    assert_select '[data-disable-with=?]', 'Update Page'
    assert_select 'a', 'Back'
  end

  def test_create_page
    sign_in @site.user

    post site_pages_url(@site), params: {page: {title: 'about', url: '/about', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    assert_redirected_to site_pages_url(all: true)
  end

  def test_update_page
    sign_in @site.user

    patch site_page_url(@site, @page_1), params: {page: {title: 'about1', url: '/about1', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    assert_redirected_to site_pages_url(all: true)
  end

  def test_del_page
    sign_in @site.user

    delete site_page_url(@site, @page_1.id)
    assert_redirected_to site_pages_url(all: true)
  end

end
