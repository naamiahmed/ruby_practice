# Mastermind Game Implementation
class Mastermind
  COLORS = %w[red blue green yellow orange purple].freeze
  TURNS = 12

  def initialize
    @secret_code = []
  end

  def play
    puts "Welcome to Mastermind!"
    puts "Do you want to be the codebreaker or codemaker? (Enter 'breaker' or 'maker')"
    role = gets.chomp.downcase

    if role == 'breaker'
      setup_secret_code
      human_codebreaker
    elsif role == 'maker'
      human_codemaker
    else
      puts "Invalid input. Exiting game."
    end
  end

  private

  # --- Human as Codebreaker ---
  def setup_secret_code
    @secret_code = Array.new(4) { COLORS.sample }
  end

  def human_codebreaker
    TURNS.times do |turn|
      puts "\nTurn #{turn + 1}/#{TURNS}:"
      puts "Available colors: #{COLORS.join(', ')}"
      print "Enter your guess (e.g., 'red blue green yellow'): "
      guess = gets.chomp.split

      if valid_guess?(guess)
        feedback = give_feedback(guess)
        puts "Feedback: #{feedback[:exact]} exact matches, #{feedback[:near]} near matches"

        if feedback[:exact] == 4
          puts "Congratulations! You cracked the code: #{@secret_code.join(' ')}"
          return
        end
      else
        puts "Invalid guess. Try again."
      end
    end

    puts "Sorry, you've used all your turns. The secret code was: #{@secret_code.join(' ')}"
  end

  # --- Computer as Codebreaker ---
  def human_codemaker
    print "Enter your secret code (e.g., 'red blue green yellow'): "
    @secret_code = gets.chomp.split

    unless valid_guess?(@secret_code)
      puts "Invalid code. Restart the game and try again."
      return
    end

    possible_codes = COLORS.repeated_permutation(4).to_a
    TURNS.times do |turn|
      guess = possible_codes.sample
      puts "\nTurn #{turn + 1}/#{TURNS}: Computer's guess: #{guess.join(' ')}"
      feedback = give_feedback(guess)

      if feedback[:exact] == 4
        puts "The computer guessed your code: #{guess.join(' ')}! It wins!"
        return
      end

      possible_codes.select! do |code|
        give_feedback(code) == feedback
      end
    end

    puts "The computer failed to guess your code: #{@secret_code.join(' ')}."
  end

  # --- Helper Methods ---
  def valid_guess?(guess)
    guess.size == 4 && guess.all? { |color| COLORS.include?(color) }
  end

  def give_feedback(guess)
    exact = guess.zip(@secret_code).count { |g, s| g == s }
    near = guess.uniq.count { |color| @secret_code.include?(color) } - exact
    { exact: exact, near: near }
  end
end

# Start the game
game = Mastermind.new
game.play
