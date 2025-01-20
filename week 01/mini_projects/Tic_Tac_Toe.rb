class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def display
    @grid.each_with_index do |row, index|
      puts row.map { |cell| cell.empty? ? ' ' : cell }.join(' | ')
      puts '---+---+---' unless index == 2
    end
  end

  def update(row, col, marker)
    if @grid[row][col] == ' '
      @grid[row][col] = marker
      true
    else
      false
    end
  end

  def full?
    @grid.all? { |row| row.none?(' ') }
  end

  def winner?
    rows = @grid
    cols = @grid.transpose
    diags = [[@grid[0][0], @grid[1][1], @grid[2][2]],
             [@grid[0][2], @grid[1][1], @grid[2][0]]]

    (rows + cols + diags).any? { |line| line.uniq.length == 1 && line.first != ' ' }
  end
end

class TicTacToe
  def initialize
    @board = Board.new
    @current_player = 'X'
  end

  def play
    puts "Welcome to Tic Tac Toe!"
    until game_over?
      @board.display
      take_turn
      switch_player
    end
    @board.display
    display_result
  end

  private

  def take_turn
    puts "Player #{@current_player}, enter your move (row and column: 0, 1, or 2):"
    row, col = gets.chomp.split.map(&:to_i)

    if valid_move?(row, col)
      @board.update(row, col, @current_player)
    else
      puts "Invalid move. Try again."
      take_turn
    end
  end

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board.grid[row][col] == ' '
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def game_over?
    @board.winner? || @board.full?
  end

  def display_result
    if @board.winner?
      switch_player 
      puts "Player #{@current_player} wins!"
    else
      puts "It's a draw!"
    end
  end
end

game = TicTacToe.new
game.play
