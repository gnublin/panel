class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(url)
    Resque.logger = Logger.new(STDOUT)
    Resque.logger.info "eee"
    puts "#{Time.now}: Message arrived"

    logstash_connection = TCPSocket.new('192.168.73.2', 5454)
    check_result = `phantomas http://#{url}:3000 --format json`
    # # check_result = "#{check_result}]"
    # if valid_json? check_result
    #   test = JSON.parse(check_result).kind_of?(Hash)
    #   puts "#{Time.now}: Message in progress"
    #   logstash_connection.write(test)
    #   logstash_connection.print("hello")
    #   logstash_connection.close
    # else
    #   puts "#{Time.now}: Eror message (not a valid json)"
    # end
    # puts "#{Time.now}: Message processed"
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue
      false
  end
end
