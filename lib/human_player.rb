require './lib/player'
require './lib/board_pos_to_index'
require './lib/ship'
require './lib/game_board'
class HumanPlayer < Player

  def add_legal_ship(ship)
    initial_ship_count = @ship_log.count
    puts "\nyou are placing a ship of length #{ship.hp}"
    puts "Please input a row letter and column number (e.x. a2, b4)\n"
    while @ship_log.count == initial_ship_count
      attempt_to_add_ship(ship)
    end
    puts "successfully placed ship"
  end

  def attempt_to_add_ship(ship)
    converter = BoardPosToIndex.new
    puts "What is your choice of starting square?"
    ship_start = gets.chomp
    puts "What is your choice of ending square?"
    ship_end   = gets.chomp
    converted_start = converter.convert(ship_start)
    converted_end   = converter.convert(ship_end)
    add_ship(ship, converted_start, converted_end)
  end

  def enter_legal_shot(board)
    converter = BoardPosToIndex.new
    initial_shot_count = (@miss_history + @hit_history).count
    while (@miss_history + @hit_history).count == initial_shot_count
      puts "What is your target?"
      target = gets.chomp
      converted_target = converter.convert(target)
      shot_location = hit(board, converted_target.first, converted_target.last)
    end
    shot_location
  end

end
