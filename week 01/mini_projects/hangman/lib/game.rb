# lib/game.rb
require 'yaml'

class HangmanGame
  attr_accessor :word, :guessed_letters, :incorrect_guesses, :remaining_attempts, :game_over

  def initialize(word)
    @word = word
    @guessed_letters = []
    @incorrect_guesses = []
    @remaining_attempts = 6
    @game_over = false
  end

  def display_word
    display = @word.chars.map { |letter| @guessed_letters.include?(letter) ? letter : "_" }.join(" ")
    puts "\nWord: #{display}"
  end

  def guess_letter(letter)
    if @game_over
      puts "Game Over! Start a new game."
      return
    end

    letter = letter.downcase
    if @guessed_letters.include?(letter) || @incorrect_guesses.include?(letter)
      puts "You already guessed '#{letter}'. Try again."
      return
    end

    if @word.include?(letter)
      @guessed_letters << letter
      puts "Correct guess!"
    else
      @incorrect_guesses << letter
      @remaining_attempts -= 1
      puts "Incorrect guess. You have #{@remaining_attempts} attempts left."
    end

    check_game_status
  end

  def check_game_status
    if @remaining_attempts <= 0
      @game_over = true
      puts "Game Over! The word was '#{@word}'."
    elsif (@word.chars - @guessed_letters).empty?
      @game_over = true
      puts "Congratulations! You guessed the word '#{@word}'!"
    end
  end

  def save_game(filename)
    File.open(filename, 'w') { |file| file.write(self.to_yaml) }
    puts "Game saved!"
  end

  def self.load_game(filename)
    YAML.load_file(filename)
  end
end
