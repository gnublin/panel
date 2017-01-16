namespace :make_stats do
  desc "get stats"
  task get: :environment do
    MakeStatsJob.perform_later 'localhost'
  end

end
