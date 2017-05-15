class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(site, page, manual)
    Resque.logger = Logger.new(STDOUT)
    Resque.logger.info '----------------'
    Resque.logger.info 'Message arrived'

    manual = manual == "true" ? true : false
    stats_keys = %w[requests postRequests httpsRequests notFound timeToFirstByte timeToLastByte bodySize contentLength httpTrafficCompleted]
    size_format = '1280x1024'
    device_format = 'computer'
    user_agent = 'phantomas/0.6.0 (PhantomJS/1.9.0; linux 64bit))'
    temp_file = Tempfile.new
    temp_file.close
    url = "#{site.url}/#{page.url}"
    size_format = page.size if page.size && page.size != size_format
    device_format = page.device if page.device && page.device != device_format
    case page.device
    when 'tablet'
      device_format = '--tablet'
      device = 'Tablet'
    when 'phone'
      device_format = '--phone'
      device = 'Phone'
    else
      device_format = ''
      device = 'Computer'
    end

    if page.useragent
      user_agent = 'page.useragent - phantomas/0.6.0 (PhantomJS/1.9.0; linux 64bit)'
    end

    Resque.logger.info url
    Resque.logger.info device_format
    Resque.logger.info size_format

    har_res_json = %x(phantomas #{url} --har=#{temp_file.path} --viewport=#{size_format} #{device_format} --format json --user-agent '#{user_agent}')
    har_res = JSON.parse(har_res_json)

    har_metrics = har_res['metrics'].slice(*stats_keys).map { |k, v| [k.to_sym, v.to_i] }.to_h

    Resque.logger.info har_res['metrics']['contentLength']
    Resque.logger.info har_res['metrics']['']

    Run.create(page: page, har: IO.readlines(temp_file.path)[0], manual: manual, device: device, size: size_format, url: url, **har_metrics)
    %x(rm #{temp_file})
    Resque.logger.info 'Message processed'
    Resque.logger.info '----------------'
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue
    false
  end

end
