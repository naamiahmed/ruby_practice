def caesar_cipher(input, shift)
  shift %= 26
  
  input.chars.map do |char|
    if char =~ /[A-Za-z]/  
      base = char.ord < 91 ? 'A'.ord : 'a'.ord  
      
      ((char.ord - base + shift) % 26 + base).chr
    else
      char  
    end
  end.join
end

puts "please enter the  text" 
text = gets
puts "OutPut"
puts caesar_cipher(text, 5)  
