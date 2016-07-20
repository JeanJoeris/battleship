require './lib/player'
require './lib/board_pos_to_index'
require './lib/ship'
require './lib/game_board'
class HumanPlayer < Player




  def add_legal_ship(ship)
    converter = HumanNotationToIndex.new
    initial_ship_count = @ship_log.count
    board_size = @board.get_board.count
    while @ship_log.count == initial_ship_count
      puts "What is your choice of starting square?"
      ship_start = gets.chomp
      puts "What is your choice of ending square?"
      ship_end   = gets.chomp
      converted_start = converter.convert(ship_start)
      converted_end   = converter.convert(ship_end)
      add_ship(ship, converted_start, converted_end)
    end
  end

  def enter_legal_shot

  end

end
board = GameBoard.new(4,4)
ship = Ship.new(3)
human = HumanPlayer.new(board)
human.add_legal_ship(ship)
