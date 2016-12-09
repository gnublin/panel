require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
  end

  def test_reject_unauthenticated_request
    get site_pages_url(@site)
    assert_redirected_to new_user_session_url
  end

  def test_should_get_index
    sign_in @site.user

    get site_pages_url(@site)
    assert_response :ok
  end
end
