require 'pry'
require './lib/game_board'
require './lib/ship'
require './lib/validator'

class ShipPlacer

  def initialize(board)
    @board = board
  end

  def place_ship(ship, start_location, ending_location)
    locations = get_locations(start_location, ending_location)
    if Validator.new(@board).valid_placement?(ship, start_location, ending_location)
      locations.each do |location|
        @board.add_ship(ship, location)
      end
    else
      []
    end
  end

  def get_locations(start_location, ending_location)
    locations = []
    if swap_locations?(start_location, ending_location)
      start_location, ending_location = ending_location, start_location
    end
    range = get_cell_range(start_location, ending_location)
    unless range
      return []
    end
    range.each do |num|
      if same_row?(start_location, ending_location)
        locations << [start_location[0], num]
      elsif same_column?(start_location, ending_location)
        locations << [num, start_location[1]]
      end
    end
    locations
  end

  def swap_locations?(start_location, ending_location)
    misordered_row = start_location.first > ending_location.first
    misordered_column = start_location.last > ending_location.last
    misordered_row || misordered_column
  end



  def get_cell_range(start_location, ending_location)
    if same_row?(start_location, ending_location)
      range = (start_location[1]..ending_location[1])
    elsif same_column?(start_location, ending_location)
      range = (start_location[0]..ending_location[0])
    end
  end

  def same_row?(start_location, ending_location)
    start_location[0] == ending_location[0]
  end

  def same_column?(start_location, ending_location)
    start_location[1] == ending_location[1]
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
