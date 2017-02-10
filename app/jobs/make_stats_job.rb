class MakeStatsJob < ApplicationJob
  queue_as :default
  def perform(site, page, manual)
    manual = manual ? true : false
    Resque.logger = Logger.new(STDOUT)
    Resque.logger.info "----------------"
    Resque.logger.info "Message arrived"
    size_format = "1280x1024"
    device_format = "computer"
    temp_file = Tempfile.new
    temp_file.close
    url = "#{site.url}/#{page.url}"
    size_format = page.size if page.size && page.size != size_format
    device_format = page.device if page.device && page.device != device_format
    case page.device
    when "tablet"
      device_format = "--tablet"
      device = "Tablet"
    when "phone"
      device_format = "--phone"
      device = "Phone"
    else
      device_format = ""
      device = "Computer"
    end

    Resque.logger.info "#{url}"
    Resque.logger.info "#{device_format}"
    Resque.logger.info "#{size_format}"

    `phantomas #{url} --har=#{temp_file.path} --viewport=#{size_format} #{device_format}`
    Run.create(page: page, har: JSON.parse(IO.readlines(temp_file.path)[0]), manual: manual, device: device, size: size_format, url: url)

    Resque.logger.info "Message processed"
    Resque.logger.info "----------------"
  end


  def valid_json?(json)
    test_parse = JSON.parse(json)
    true
  rescue
    false
  end

end
