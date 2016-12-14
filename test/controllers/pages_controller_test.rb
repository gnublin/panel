require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
    @page = create :page, site: @site
  end

  def test_pages_reject_unauthenticated_request
    get site_pages_url(@site.id)
    assert_redirected_to new_user_session_url
  end

  def test_index_pages
    sign_in @site.user

    get site_pages_url(@site)
    assert_response :ok
  end

  def test_show_page
    sign_in @site.user

    get site_page_url(@site, @page)
    assert_response :ok
  end

  def test_new_page
    sign_in @site.user

    get new_site_page_url(@site)
    assert_response :ok
  end

  def test_edit_page
    sign_in @site.user

    get edit_site_page_url(@site, @page)
    assert :ok
  end

  def test_create_page
    sign_in @site.user

    post site_pages_url(@site), params: {page: {title: 'about', url: '/about', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    assert_redirected_to site_pages_url(all: true)
  end

  def test_update_page
    sign_in @site.user

    patch site_page_url(@site, @page), params: {page: {title: 'about1', url: '/about1', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    assert_redirected_to site_pages_url(all: true)
  end

  def test_del_page
    sign_in @site.user

    delete site_page_url(@site, @page.id)
    assert_redirected_to site_pages_url(all: true)
  end

end
