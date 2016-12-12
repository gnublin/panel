require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
    @page = create :page, site: @site
  end

  def test_view_all_pages
    sign_in @site.user

    get site_pages_url(@site)
    assert_response :ok
  end

  def test_get_new_page_page
    sign_in @site.user

    get new_site_page_url(@site)
    assert_response :ok
  end

  def test_add_new_page
    sign_in @site.user

    post site_pages_url(@site), params: {page: {title: 'about', url: '/about', active: true, email: 'g@doctolib.fr', basic_auth: 'none', basic_password: 'none'}}
    assert_redirected_to site_pages_url(all: true)
  end


end
