class TimeFormat

  TIME_FORMATS = {
    year:   '%Y',
    month:  '%m',
    day:    '%d',
    hour:   '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  def initialize(params)
    @params = params['format'].split(',')
  end

  def wrong_format
    @wrong_format ||= (@params - TIME_FORMATS.keys)
  end

  def check_format
    valid_format = []
    @params.each { |format| valid_format << TIME_FORMATS[format.to_sym] }
    valid_format.join('-')
  end

  def valid_format?
    wrong_format.empty?
  end

  def success_format
    Time.now.strftime(check_format)
  end
end
