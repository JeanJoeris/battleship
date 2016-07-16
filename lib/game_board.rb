require './lib/game_cell'
require "pry"
class GameBoard

  def initialize(rows, columns)
    @board = Array.new(rows, Array.new(columns, GameCell.new))
  end

  def board(row_index, column_index)
    if row_index < @board.count
      @board[row_index][column_index]
    else
      nil
    end
  end

  def add_to_cell(row_index, column_index, content)
    if row_index < @board.count && column_index < @board[0].count
      board(row_index, column_index).add(content)
    else
      nil
    end
  end

  
end
