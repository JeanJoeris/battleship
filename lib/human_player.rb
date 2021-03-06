require './lib/player'
require './lib/board_pos_to_index'
require './lib/ship'
require './lib/game_board'
class HumanPlayer < Player

  def add_legal_ship(ship)
    initial_ship_count = @ship_log.count
    puts "\nyou are placing a ship of length #{ship.hp}"
    puts "Please input a pair of coordinates (e.x. a1 a#{ship.hp})\n"
    while @ship_log.count == initial_ship_count
      attempt_to_add_ship(ship)
    end
    puts "successfully placed ship"
  end

  def attempt_to_add_ship(ship)
    converter = BoardPosToIndex.new
    ship_locations = gets.chomp.gsub(",", " ").split(" ")
    if is_valid_input?(ship_locations.first, ship_locations.last)
      converted_start = converter.convert(ship_locations.first)
      converted_end   = converter.convert(ship_locations.last)
      add_ship(ship, converted_start, converted_end)
    else
      puts "Invalid syntax, please enter a pair of coordinates"
    end
  end

  def is_valid_input?(*locations)
    validations = locations.map do |location|
      location =~ /[a-zA-Z]\d/
    end
    if validations.include?(nil)
      false
    else
      true
    end
  end

  def enter_legal_shot(board)
    converter = BoardPosToIndex.new
    initial_shot_count = (@miss_history + @hit_history).count
    while (@miss_history + @hit_history).count == initial_shot_count
      puts "What is your target?"
      target = gets.chomp
      if is_valid_input?(target)
        converted_target = converter.convert(target)
        shot_location = hit(board, converted_target.first, converted_target.last)
      else
        puts "Invalid syntax, please enter a coordinate"
      end
    end
    shot_location
  end

end
