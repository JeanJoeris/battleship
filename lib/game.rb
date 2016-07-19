require './lib/game_board'
class Game
  attr_reader :player_board,
              :computer_board,
              :miss_history,
              :hit_history,
              :ship_log

  def initialize(difficulty = "easy")
    size = get_size_by_difficulty(difficulty)
    board = GameBoard.new(size, size)
    @player_board = board
    @computer_board = board
    @miss_history = {}
    @hit_history = {}
    @ship_log = {}
  end

  def get_size_by_difficulty(difficulty)
    if difficulty.downcase == "medium"
      8
    elsif difficulty.downcase == "hard"
      12
    else
      4
    end
  end

  def shoot(board, row_index, column_index)
    target_cell = board.cell(row_index, column_index)
    target_cell.hit
    if target_cell.content
      record_hit(@hit_history, board, row_index, column_index)
    else
      record_hit(@miss_history, board, row_index, column_index)
    end
  end

  def record_hit(shot_history, board, row_index, column_index)
    unless shot_history[board]
      shot_history[board] = [[row_index, column_index]]
    else
      shot_history[board] << [row_index, column_index]
    end
  end

  def add_ship(board, ship, start_location, ending_location)
    board.add_ship(ship, start_location, ending_location)
    unless @ship_log[board]
      @ship_log[board] = [ship]
    else
      @ship_log[board] << ship
    end
  end

end
