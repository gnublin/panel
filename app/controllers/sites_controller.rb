class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy]


  def index
    @sites = params[:all] == 'true' ? Site.where(user_id: current_user.id) : Site.where(active: true, user_id: current_user.id)
  end

  def show
  end

  def new
    @site = Site.new(user: current_user)
  end

  def edit
  end

  def create
    # @site = Site.new(site_params)
    @site = current_user.sites.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to site_path(@site), notice: "Site #{@site['name']} was successfully created." }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to site_path(@site), notice: "Site #{@site['name']} was successfully updated." }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: "Site #{params['name']} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.where(site_id: params[:id])
    end

    def set_site
      @site = current_user.sites.find(params[:id])
      # @site = Site.where(id: params[:id], user_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:url, :active, :name)
    end
end
