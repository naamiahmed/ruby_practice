# main.rb

# Load the necessary files
require_relative 'lib/phone_number_cleaner'
require_relative 'lib/time_targeting'
require_relative 'lib/day_targeting'

# Test for Part 1: Phone Number Cleaning
phone_numbers = [
  "123-456-7890",    # Good
  "11234567890",     # Trim first 1
  "21234567890",     # Bad
  "(123) 456-7890",  # Good
  "12345",           # Bad
  "1234567890123"    # Bad
]
puts "Cleaned phone numbers:"
cleaned_numbers = phone_numbers.map { |number| clean_phone_number(number) }
puts cleaned_numbers

# Test for Part 2: Peak Registration Hours
registration_times = [
  "2025-01-19 14:23:45",
  "2025-01-19 15:45:12",
  "2025-01-19 14:12:34",
  "2025-01-19 18:10:55",
  "2025-01-19 15:33:22"
]
puts "\nPeak registration hours:"
peak_hours = peak_registration_hours(registration_times)
puts peak_hours

# Test for Part 3: Peak Registration Days
puts "\nPeak registration days:"
peak_days = peak_registration_days(registration_times)
puts peak_days.map { |day| Date::DAYNAMES[day] }
