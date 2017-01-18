require 'resque/tasks'


task 'resque:setup' => :environment do

  Resque.logger.info "d"
end
