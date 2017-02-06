class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(url)
    Resque.logger = Logger.new(STDOUT)
    Resque.logger.info "----------------"
    Resque.logger.info "Message arrived"
    new_hash = {}
    offenders_mapping = {
      time: [
        'redirects', 'fastestResponse', 'slowestResponse', 'biggestLatency',
        'timeToFirstCss', 'smallestLatency', 'timeToFirstJs'
        ],
      orig: [
        'jQueryEventTriggers', 'jQueryDOMWrites', 'DOMqueriesByQuerySelectorAll',
        'DOMmutationsInserts', 'globalVariables', 'domainsWithCookies', 'DOMinserts',
        'DOMqueriesByTagName', 'jQueryVersionsLoaded', 'domainsToDomComplete',
        'DOMqueriesDuplicated', 'DOMmutationsRemoves', 'domainsToDomContentLoaded',
        'jQueryDOMWriteReadSwitches', 'DOMelementMaxDepth', 'jQueryOnDOMReadyFunctions',
        'domains', 'DOMmutationsAttributes', 'eventsBound', 'jQuerySizzleCalls',
        'headersBiggerThanContent'
        ],

      }

    logstash_connection = TCPSocket.new('192.168.101.2', 5454)
    # logstash_connection = TCPSocket.new('192.168.73.2', 5454)
    url_all = "http://#{url}:3000"
    check_result = `phantomas #{url_all} --format json`

    test_json = valid_json? check_result
    if test_json.first
      Resque.logger.info "Is a valid_json"
      json_parser = test_json[1]
      # p json_parser['offenders'].to_json
      # exit
      new_hash['metrics'] = json_parser['metrics']
      new_hash['url'] = json_parser['url']
      offenders = json_parser['offenders']

      offenders_mapping.each do |k, v|
        case k
        when :time
          v.each do |offender|
            # p offenders[offender].first
            # extract_value offenders[offender].first
            # p "ff"
            offenders[offender].each do |t|
              extracted_value = extract_value t
              index_t = offenders[offender].index(t)
              # p offenders[offender]
              next if extracted_value.nil?
              new_hash[offender] = {time: "#{extracted_value.first}-#{index_t}", path: "#{extracted_value.last.gsub(url_all, '')}-#{index_t}"}
            end
          end
        when :orig
          v.each do |orig_key|
            new_hash[orig_key] = offenders[orig_key]
          end
        end
        logstash_connection.write(new_hash.to_json)
      end
    else
      Resque.logger.error "Is not a valid json"
    end
    Resque.logger.info "Message processed"
    Resque.logger.info "----------------"
  end


  def valid_json?(json)
    test_parse = JSON.parse(json)
    [true, test_parse]
  rescue
    [false]
  end

  def extract_value(to_split)
    res_splitted = to_split.match /(.*)\s\(\D*\s?(\w+\.?\w+).*\)$/
    if res_splitted
      res_key = res_splitted[2].strip
      res_val = res_splitted[1].strip
      [res_key, res_val]
    end
  end
end
