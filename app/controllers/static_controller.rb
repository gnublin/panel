class StaticController < ApplicationController
  # before_action :set_site, only: [:home]
  before_action :set_sites, only: [:home]

  def home

    @all_pages = {}
    @metrics = {}

    @sites.each do |site|
       Page.where(site_id: site.id).each do |page|
         page_run = Run.where(page_id: page.id).limit(10)
         next if page_run.size < 1
         @metrics["#{site.url}/#{page.url}"] = read_har_stats which: 'average_load', runs: page_run
       end
    end

  end

  private
    def set_sites
      @sites = Site.all
    end

    def set_page
      @pages = Page.all
    end

    def read_har_stats which:, runs:
      res = {}
      case which
      when 'average_load'
        tmp_res = []
        runs.each do |run|
          next unless eval(run.har)[:log]
          next if eval(run.har)[:log][:entries][0].nil?
          tmp_res << eval(run.har)[:log][:entries][0][:time]
        end
        if tmp_res.size > 1
          res[:load] = {}
          res[:load][:average] = tmp_res.reduce(:+) / tmp_res.size.to_f
          if tmp_res[0].to_f > res[:load][:average]
            res[:load][:trend] = 'down'
          elsif tmp_res[0].to_f < res[:load][:average]
            res[:load][:trend] = 'up'
          else
            res[:load][:trend] = 'flat'
          end
        end
        return res
      end
    end
end
