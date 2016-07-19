require './lib/game_board'
class Game
  attr_reader :player_board,
              :computer_board

  def initialize(difficulty = "easy")
    if difficulty.downcase == "easy"
      size = 4
    elsif difficulty.downcase == "medium"
      size = 8
    elsif difficulty.downcase == "hard"
      size = 12
    else
      size = 4
    end
    board = GameBoard.new(size, size)
    @player_board = board
    @computer_board = board
  end

end
