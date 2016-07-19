require 'pry'
require './lib/game_board'
require './lib/ship'
class ShipPlacer

  def initialize(board)
    @board = board
  end

  def place_ship(ship, start_location, ending_location)
    if valid_placement?(ship, start_location, ending_location)
      @board.add_ship(ship, start_location, ending_location)
    else
      []
    end
  end

  def valid_placement?(ship, start_location, ending_location)
    conditions = [shares_row_or_column?(ship, start_location, ending_location),
                  !out_of_bounds?(start_location, ending_location),
                  valid_length?(ship, start_location, ending_location)
                 ]
    conditions.inject do |final_answer, condition|
      final_answer && condition
    end
  end

  def valid_length?(ship, starting_location, ending_location)
      locations = ship.get_locations(starting_location, ending_location)
      locations.count == ship.hp
  end

  def out_of_bounds?(*locations)
    answers = locations.map do |location|
      if location[0] >= @board.get_board.count
        true
      elsif location[1] >= @board.get_board[0].count
        true
      elsif location[0] < 0 || location[1] < 0
        true
      else
        false
      end
    end
    answers.inject do |final_answer, single_answer|
      final_answer || single_answer
    end
  end

  def shares_row_or_column?(ship, start_location, ending_location)
    ship.same_row?(start_location, ending_location) || ship.same_column?(start_location, ending_location)
  end
end

# this is a proof of concept of a menu to force
# player to keep placing until legal placement
#
# board = GameBoard.new(4,4)
# ship = Ship.new(3)
# ship_placer = ShipPlacer.new(board)
# ship_placement = []
# while ship_placement == [] do
#   input_1 = [rand(4), rand(4)]
#   input_2 = [rand(4), rand(4)]
  # puts "where shall I place your ship?\n"
  # puts "first square is? >"
  # input_1 = gets.chomp.split(",")
  # input_1.map! do |num|
  #   num = num.to_i
  # end
  # puts "second square is? >"
  # input_2 = gets.chomp.split(",")
  # input_2.map! do |num|
  #   num = num.to_i
  # end
#   puts
#   p input_1
#   puts
#   p input_2
#   puts
#   ship_placement = ship_placer.place_ship(ship, input_1, input_2)
# end
# puts "thank you meatbag"
# p board.get_board
