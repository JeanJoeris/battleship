class Player

  attr_reader :board,
              :miss_history,
              :hit_history,
              :ship_log

  def initialize(board)
    @board = board
    @miss_history = []
    @hit_history = []
    @ship_log = []
  end

  def hit(row, column)
    @board.hit(row, column)
    if @board.cell(row, column).content
      @hit_history << [row, column]
    else
      @miss_history << [row, column]
    end
  end

  def add_ship(ship, *locations)
    @board.add_ship(ship, *locations)
    @ship_log << ship
  end
  
end
