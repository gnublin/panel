require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    @site = create :site
    @page_1 = create :page, site: @site
    @page_2 = create :page, site: @site, title: 'My page2', url: 'toto42', active: true, email: 'ga@doctolib.fr'
  end

  def test_sites_reject_unauthenticated_request
    get sites_url
    assert_redirected_to new_user_session_url
  end

  def test_index_sites
    sign_in @site.user
    post sites_url params: {site: {name: 'test0', url: 'http://www.test0.com', active: true }}
    post sites_url params: {site: {name: 'Test1', url: 'http://www.test1.com', active: false }}

    get sites_url
    assert_response :ok
    assert_select 'h1', 'Sites'
    assert_select 'a', 'New site'
    assert_select 'a', 'Show only active sites'
  end

  def test_show_site
    sign_in @site.user
    metrics_page_1_1 = {requests: 5, postRequests: 0, httpsRequests: 0, notFound: 0, timeToFirstByte: 24, timeToLastByte: 32, bodySize: 1_167_373, contentLength: 1_167_373, httpTrafficCompleted: 191}

    create :run, page: @page_1

    #
    # manual = true
    # size_format = '1280x1024'
    # url_page_1 = "#{@site.url}/#{@page_1.url}"
    # url_page_2 = "#{@site.url}/#{@page_2.url}"
    # device = ''
    #
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_1)
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_2)
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_3)
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_4)
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_5)
    # Run.create(page: @page_1, har: '{none: true}', manual: manual, device: device, size: size_format, url: url_page_1, **metrics_page_1_6)
    #
    # get site_url(@site)
    # assert_response :ok
    # assert_select 'h1', 'Site My super site'
    # assert_select 'h1', 'Site My super site'
  end

  def test_new_site
    sign_in @site.user

    get new_site_url
    assert_response :ok
    assert_select 'form'
    assert_select 'form input', 6
    assert_select '[data-disable-with=?]', 'Create Site'
    assert_select 'a', 'Back'
  end

  def test_edit_site
    sign_in @site.user

    get edit_site_url(@site)
    assert :ok
    assert_select 'form'
    assert_select 'form input', 7
    assert_select '[data-disable-with=?]', 'Update Site'
    assert_select 'a', 'Back'
  end

  def test_create_site
    sign_in @site.user

    assert_raise ActionController::ParameterMissing do
      post sites_url
    end

    sign_in @site.user

    post sites_url params: {site: {name: 'Test1', url: 'http://www.test1.com', active: true }}
    assert_redirected_to site_pages_url(Site.last, all: true)
  end

  def test_update_site
    sign_in @site.user

    patch site_url(@site), params: {site: {name: 'OhOhOh', url: 'http://OhOhOh.fr', active: true}}
    assert_redirected_to site_url
  end

  def test_del_site
    sign_in @site.user

    delete site_url(@site)
    assert_redirected_to sites_url
  end
end
