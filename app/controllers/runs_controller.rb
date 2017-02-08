class RunsController < ApplicationController

  def index
    per_page = params[:per_page] ? params[:per_page] : 15
    @runs =  Run.where(page_id: params[:page_id]).order(id: :desc)
    @runs = @runs.page(params[:page]).per(per_page)
    p @runs
    @page = Page.find(params[:page_id])
    @site = Site.find(params[:site_id])
    if per_page.to_i > 15
      per_page = @runs.total_count
      redirect_to site_page_runs_path(per_page: per_page)
    end

  end

  def show
  end

end
