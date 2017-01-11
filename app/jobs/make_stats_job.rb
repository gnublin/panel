class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(*args)

    url = args.first['url']
    s = logstash_connection = TCPSocket.new('localhost', 5454)

    test = `phantomas http://#{url}:3000 --format json`

    if  JSON.parse(test).kind_of?(Hash)
      s.write(test)
      s.print("hello")
      s.close
    else

      puts "#{Time.now}: Eror message"
    end
    puts "#{Time.now}: Message processed"
  end
end
