# main.rb
require_relative 'lib/hangman'
require_relative 'lib/dictionary_loader'

def start_new_game
  dictionary = load_dictionary('google-10000-english-no-swears.txt')
  word = dictionary.sample
  game = HangmanGame.new(word)
  play_game(game)
end

def play_game(game)
  until game.game_over
    game.display_word
    puts "\nIncorrect guesses: #{game.incorrect_guesses.join(', ')}"
    puts "Remaining attempts: #{game.remaining_attempts}"
    puts "\nEnter your guess (or type 'save' to save the game):"
    guess = gets.chomp.downcase

    if guess == 'save'
      game.save_game('saves/saved_game.yml')
      break
    else
      game.guess_letter(guess)
    end
  end
end

def load_game
  if File.exist?('saves/saved_game.yml')
    game = HangmanGame.load_game('saves/saved_game.yml')
    puts "\nResuming saved game..."
    play_game(game)
  else
    puts "No saved game found. Starting a new game."
    start_new_game
  end
end

puts "Welcome to Hangman!"
puts "1. Start a new game"
puts "2. Load saved game"
choice = gets.chomp.to_i

if choice == 1
  start_new_game
elsif choice == 2
  load_game
else
  puts "Invalid choice. Exiting."
end
