class RunsController < ApplicationController

  def index
    per_page = params[:per_page] ? params[:per_page] : 15
    @runs =  Run.where(page_id: params[:page_id]).order(id: :desc)
    @runs = @runs.page(params[:page]).per(per_page)
    @page = Page.find(params[:page_id])
    @site = Site.find(params[:site_id])

    if per_page.to_i > 20
    per_page = 20
      redirect_to site_page_runs_path(per_page: per_page)
    end

  end

  def show
    @run = set_run
    @har = JSON.parse(@run.har)
    @new_har = Hash.new
    @har["log"]["entries"].each do |h_entry|
      start_time = Time.iso8601 h_entry['startedDateTime']
      delta = h_entry['time']/(1000).to_f
      end_time = start_time + delta
      start_time = start_time.strftime("%s%L")
      end_time =  end_time.strftime("%s%L")
      @new_har[h_entry['request']['url']] = [start_time, end_time]
    end
    respond_to do |format|
      format.html { @new_har }
      format.json { render json: @new_har.to_json}
    end
  end

  def destroy
    @run = set_run
    @run.destroy
    respond_to do |format|
      format.html { redirect_to site_page_runs_path(page_id: params[:page], site_id: params[:site]), notice: "Run has been successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end
end
