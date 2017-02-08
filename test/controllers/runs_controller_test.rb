require 'test_helper'

class RunsControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
    @page = create :page, site: @site
  end

  def test_run_check_job
    post site_page_run_check_job_path(1, 1)
    assert_response :redirect
  end


end
