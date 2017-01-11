namespace :make_stats do
  desc "get stats"
  task get: :environment do
    args = {'url' => 'localhost'}
    MakeStatsJob.perform_later args
  end

end
