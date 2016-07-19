require './lib/game_cell'
require "pry"
class GameBoard

  def initialize(rows, columns)
    @board = Array.new(rows, Array.new(columns))
    @board.map! do |row|
      row.map do |element|
        element = GameCell.new
      end
    end
  end

  def get_board
    @board
  end

  def cell(row_index, column_index)
    if row_index < @board.count
      @board[row_index][column_index]
    else
      nil
    end
  end

  def hit(row_index, column_index)
    target_cell = cell(row_index, column_index)
    unless target_cell.hit?
      target_cell.hit
      if target_cell.content.is_a?(Ship)
        target_cell.content.hit
      end
    end
  end

  def add_to_cell(row_index, column_index, content)
    if row_index < @board.count && column_index < @board[0].count
      cell(row_index, column_index).add(content)
    else
      nil
    end
  end

  def add_ship(ship, start_location, ending_location)
    ship.set_location(start_location, ending_location)
    ship.locations.each do |row, column|
      add_to_cell(row, column, ship)
    end
  end

end
