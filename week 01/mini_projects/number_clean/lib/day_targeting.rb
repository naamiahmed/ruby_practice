# lib/day_targeting.rb
require 'date'

def peak_registration_days(registration_times)
  days = Hash.new(0)

  registration_times.each do |timestamp|
    date = Date.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
    days[date.wday] += 1
  end

  peak_days = days.select { |day, count| count == days.values.max }
  peak_days.keys
end
