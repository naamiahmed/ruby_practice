def substrings(word, dictionary)
  substring_counts = Hash.new(0)

  word = word.downcase

  dictionary.each do |substring|
    substring = substring.downcase

    count = word.scan(substring).length

    substring_counts[substring] += count if count > 0
  end

  substring_counts
end

dictionary = ["below", "low", "go", "how", "it", "hello", "world", "owl"]
word = "Hello, how low can you go below the owl world?"

puts substrings(word, dictionary)
