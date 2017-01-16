class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(url)
    Rails.logger.info "Processing the request..."
    puts "#{Time.now}: Message arrived"

    logstash_connection = TCPSocket.new('192.168.73.18', 5454)
    test = `phantomas http://#{url}:3000 --format json`
    if  JSON.parse(test).kind_of?(Hash)
      puts "#{Time.now}: Message in progress"
      logstash_connection.write(test)
      logstash_connection.print("hello")
      logstash_connection.close
    else
      puts "#{Time.now}: Eror message"
    end
    # p JSON.parse(test)
    puts "#{Time.now}: Message processed"
  end
end
