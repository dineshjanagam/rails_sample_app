class Timer
  
  attr_reader :time, :hour, :minutes, :meridian

  def initialize(time)
    @time = time
    self.parse
  end 

  def time_regex
     @_time_regex ||= /^(\d{1,2})\:(\d{2})\s([A|P]M)$/
  end

  def parse_time
    matchdata = time_regex.match(self.time)
    if matchdata and matchdata.size == 4
      @hour = matchdata[1].to_i
      @minutes = matchdata[2].to_i
      @meridian = case matchdata[3]
                   when "AM"
                    0  
                   when "PM"
                    1
                   else
                     raise "Invalid time format, Expected format: HH:MM AM|PM"
                   end
    else
        raise "Invalid time format, Expected format: HH:MM AM|PM"
    end
  end

  def validate_time
      raise "Invalid time format, Expected format: HH:MM AM|PM" unless (1..12) === @hour 
      raise "Invalid time format, Expected format: HH:MM AM|PM" unless (0..59) === @minutes
  end

  # Parsing the time
  def parse()
    self.parse_time
    self.validate_time
  end 

  def add_minutes(mins)
      return self if mins == 0

      _hour = @hour + (mins/60).remainder(24)
      _minutes = @minutes + (mins%60)
      _meridian = @meridian

      if _minutes == 60
         _hour += 1
         _minutes = 0
      elsif _minutes > 60
        _hour += 1
        _minutes -= 60         
      end 
     
      if _hour == 12
        _meridian = (_meridian-1).abs
      elsif _hour > 12
        _hour -= 12
        _meridian = (_meridian-1).abs
      elsif _hour < 0
        _hour = 12 + _hour
        _meridian = (_meridian-1).abs
      end 

      if _minutes < 10
        _minutes = "0#{_minutes}"
      end 
      "#{_hour}:#{_minutes} #{_meridian == 0 ? 'AM' : 'PM'}"
  end

  def to_s
     "#{self.hour}:#{self.minutes} #{self.meridian == 0 ? 'AM' : 'PM'}"
  end 

end