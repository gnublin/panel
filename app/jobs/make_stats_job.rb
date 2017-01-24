class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(url)
    Resque.logger = Logger.new(STDOUT)
    Resque.logger.info "#{Time.now}: Message arrived"
    new_hash = {}
    offenders_mapping = {time: ['redirects', 'fastestResponse', 'slowestResponse', 'biggestLatency', 'timeToFirstCss', 'smallestLatency', 'timeToFirstJs']}

    logstash_connection = TCPSocket.new('192.168.101.2', 5454)
    # logstash_connection = TCPSocket.new('192.168.73.2', 5454)
    check_result = `phantomas http://#{url}:3000 --format json`

    test_json = valid_json? check_result
    if test_json.first
      Resque.logger.info "is a valid_json"
      json_parser = test_json[1]
      new_hash['metrics'] = json_parser['metrics']
      new_hash['url'] = json_parser['url']
      offenders = json_parser['offenders']

      offenders_mapping.each do |k, v|
        case k
        when :time
          v.each do |offender|
            p extract_value offenders[offender].first
            extracted_value = extract_value offenders[offender].first
            new_hash[offender] = {path: extracted_value.first.gsub('http://#{url}:3000',''), time: extracted_value.last}
          end
        end
      end
    end
    p new_hash
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
    test_parse = JSON.parse(json)
    [true, test_parse]
  rescue
      [false]
  end

  def extract_value(to_split)
    res_splitted = to_split.match /(.*)\((.*)\)/
    res_key = res_splitted[2].strip
    res_val = res_splitted[1].strip
    [res_key, res_val]
  end
end
