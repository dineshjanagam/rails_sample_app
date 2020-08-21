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

  def parse()
    self.parse_time
    self.validate_time
  end 

  def add_minutes(mins)
      return self if mins == 0

      @hour += (mins/60).remainder(24)
      @minutes += (mins%60)

      if self.minutes == 60
         @hour += 1
         @minutes = 0
      elsif self.minutes > 60
        @hour += 1
        @minutes -= 60         
      end 
     
      if self.hour == 12
        @meridian = (self.meridian-1).abs
      elsif self.hour > 12
        @hour -= 12
        @meridian = (self.meridian-1).abs
      elsif self.hour < 0
        @hour += 12
        @meridian = (self.meridian-1).abs
      end 
      self 
  end

  def to_s
     "#{self.hour}:#{(self.minutes < 10 ? "0#{self.minutes}" : self.minutes)} #{self.meridian == 0 ? 'AM' : 'PM'}"
  end 

end