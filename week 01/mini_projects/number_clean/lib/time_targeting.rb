# lib/time_targeting.rb
require 'time'

def peak_registration_hours(registration_times)
  hours = Hash.new(0)

  registration_times.each do |timestamp|
    time = Time.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
    hours[time.hour] += 1
  end

  peak_hours = hours.select { |hour, count| count == hours.values.max }
  peak_hours.keys
end
