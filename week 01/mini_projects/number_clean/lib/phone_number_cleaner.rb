# lib/phone_number_cleaner.rb

def clean_phone_number(phone)
  phone = phone.gsub(/\D/, '') # Remove all non-digit characters

  if phone.length == 10
    phone
  elsif phone.length == 11 && phone[0] == '1'
    phone[1..]
  else
    'Bad Number'
  end
end
