class TimeFormat
  VALID_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  attr_reader :invalid

  def initialize(params)
    @valid = []
    @invalid = []
    @formats = params['format'].split(',')

    detect_formats
  end

  def call
    Time.now.strftime(@valid.join('-'))
  end

  def valid?
    invalid.empty?
  end

  private

  def detect_formats
    @formats.each do |format|
      if VALID_FORMATS[format]
        @valid << VALID_FORMATS[format]
      else
        @invalid << format
      end
    end
  end
end
