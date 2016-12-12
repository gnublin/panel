require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
  end

  def test_sites_reject_unauthenticated_request
    get sites_url
    assert_redirected_to new_user_session_url
  end

  def test_should_get_index
    sign_in @site.user

    get site_pages_url(@site)
    assert_response :ok
  end

  def test_get_new_site_page
    sign_in @site.user

    get new_site_url
    assert_response :ok
  end

  def test_add_new_site
    sign_in @site.user
    assert_raise ActionController::ParameterMissing do
      post sites_url
    end

    sign_in @site.user
    post sites_url params: {site: {name: 'Test1', url: 'http://www.test1.com', active: true }}
    assert_redirected_to site_url(Site.last)
  end

  def test_del_site
    sign_in @site.user

    delete site_url(@site)
    assert_redirected_to sites_url
  end
end
