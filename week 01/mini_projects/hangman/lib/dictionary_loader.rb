# lib/dictionary_loader.rb

def load_dictionary(file_path)
  words = []
  File.foreach(file_path) do |line|
    word = line.strip.downcase
    words << word if word.length >= 5 && word.length <= 12
  end
  words
end
