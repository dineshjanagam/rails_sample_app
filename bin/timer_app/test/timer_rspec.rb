require_relative './../bin/timer'

describe Timer do

   it "Invalid time input - bad minutes" do
       expect { Timer.new("10:1 PM") }.to raise_error(RuntimeError,
       "Invalid time format, Expected format: HH:MM AM|PM")
   end  

   it "Invalid time input - missing meridian" do
       expect { Timer.new("11:30") }.to raise_error(RuntimeError,
       "Invalid time format, Expected format: HH:MM AM|PM")
   end  

   it "Invalid time input - missing hour" do
       expect { Timer.new(":30 PM") }.to raise_error(RuntimeError,
       "Invalid time format, Expected format: HH:MM AM|PM")
   end  

   it "Invalid time input - not a valid time" do
       expect { Timer.new("99:99 PM") }.to raise_error(RuntimeError,
       "Invalid time format, Expected format: HH:MM AM|PM")
   end
   
   it "Add Minutes to Time with hour only change" do
       new_time = Timer.new("9:00 AM").add_minutes(60)
       expect(new_time).to eq "10:00 AM"
   end 

   it "Add Minutes to Time with mins only change" do
       new_time = Timer.new("9:00 AM").add_minutes(15)
       expect(new_time).to eq "9:15 AM"
   end 

   it "Add Minutes to Time with both hours and mins change" do
       new_time = Timer.new("9:00 AM").add_minutes(85)
       expect(new_time).to eq "10:25 AM"
   end

   it "Add Minutes to Time with negative hour only change" do
       new_time = Timer.new("9:00 AM").add_minutes(-60)
       expect(new_time).to eq "8:00 AM"
   end 
   
   it "Add Minutes to Time with negative mins only change" do
       new_time = Timer.new("9:00 AM").add_minutes(-15)
       expect(new_time).to eq "8:45 AM"
   end   

   it "Add Minutes to Time with Meridian change" do
       new_time = Timer.new("11:30 AM").add_minutes(120)
       expect(new_time).to eq "1:30 PM"
   end    

   it "Add negative Minutes to Time with Meridian change" do
       new_time = Timer.new("1:30 AM").add_minutes(-120)
       expect(new_time).to eq "11:30 PM"
   end
   
   it "Check Noon time addition" do
       new_time = Timer.new("11:30 AM").add_minutes(30)
       expect(new_time).to eq "12:00 PM"
   end

   it "Check midnight time addition" do
       new_time = Timer.new("11:30 PM").add_minutes(30)
       expect(new_time).to eq "12:00 AM"
   end

   it "Check after midnight time addition" do
       new_time = Timer.new("11:35 PM").add_minutes(30)
       expect(new_time).to eq "12:05 AM"
   end
   
   it "Should change meridian" do
       new_time = Timer.new("11:35 PM").add_minutes(12 * 60)
       expect(new_time).to eq "11:35 AM"
   end
   
   it "Add one whole day" do
       new_time = Timer.new("11:35 PM").add_minutes(24 * 60)
       expect(new_time).to eq "11:35 PM"
   end

   it "Remove one whole day" do
       new_time = Timer.new("11:35 PM").add_minutes(-24 * 60)
       expect(new_time).to eq "11:35 PM"
   end
 
   it "Add 5 days" do
       new_time = Timer.new("11:35 PM").add_minutes(5 * 24 * 60)
       expect(new_time).to eq "11:35 PM"
   end

   it "Remove 5 days" do
       new_time = Timer.new("11:35 PM").add_minutes(-5 * 24 * 60)
       expect(new_time).to eq "11:35 PM"
   end   

end 