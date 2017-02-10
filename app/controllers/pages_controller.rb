class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :page_check_job]
  before_action :set_site
  # GET /pages
  # GET /pages.json
  def index
    @pages = params[:active] == 'true' ? @site.pages.where(active: true) : @site.pages
    per_page = params[:per_page] ? params[:per_page] : 5
    @pages = @pages.page(params[:page]).per(per_page)
    if per_page.to_i > 15
      per_page = 15
      redirect_to site_pages_path(per_page: per_page, active: params[:active])
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new(site: @site)
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = @site.pages.create(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to site_pages_path(all: true), notice: "Page #{@page['title']} was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to site_pages_path(all: true), notice: "Page #{@page['title']} was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to site_pages_path(all: true), notice: "Page #{@page['title']} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def run_check_job

    page = Page.find(params[:page_id])
    site = Site.find(params[:site_id])
    manual = params[:manual]
    if MakeStatsJob.perform_later site, page, manual
      notice = "Check ran"
    else
      notice = "Check not ran"
    end

    redirect_to site_pages_path(active: params[:active], per_page: params[:per_page]), notice: notice
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    def set_site
      @site = Site.find(params[:site_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      page_params = params.require(:page).permit(:site_id, :title, :url, :active, :email, :basic_auth, :basic_password, :size, :device)
      if !page_params[:size] || page_params[:size].empty?
        page_params[:size] = "1280x1024"
      end
      page_params
    end
end
