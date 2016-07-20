require './lib/ship_placer'

class Player

  attr_reader :board,
              :miss_history,
              :hit_history,
              :ship_log

  def initialize(board)
    @board = board
    @ship_placer = ShipPlacer.new(@board)
    @miss_history = []
    @hit_history = []
    @ship_log = []
  end

  def hit(board, row, column)
    unless previous_shot?(row, column)
      board.hit(row, column)
      if board.cell(row, column).content
        @hit_history << [row, column]
      else
        @miss_history << [row, column]
      end
    end
  end

  def previous_shot?(row, column)
    @hit_history.include?([row, column]) ||
     @miss_history.include?([row, column])
  end

  def add_ship(ship, start_location, ending_location)
    placed_locations =
    @ship_placer.place_ship(ship, start_location, ending_location)
    @ship_log << ship if placed_locations != []
  end

end
