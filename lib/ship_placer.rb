require 'pry'
require './lib/game_board'
require './lib/ship'
class ShipPlacer

  def initialize(board)
    @board = board
  end

  def get_locations(start_location, ending_location)
    locations = []
    if swap_locations?(start_location, ending_location)
      start_location, ending_location = ending_location, start_location
    end
    range = get_cell_range(start_location, ending_location)
    if range != nil
      range.each do |num|
        if same_row?(start_location, ending_location)
          locations << [start_location[0], num]
        elsif same_column?(start_location, ending_location)
          locations << [num, start_location[1]]
        end
      end
    end
    locations
  end

  def swap_locations?(start_location, ending_location)
    misordered_row = start_location.first > ending_location.first
    misordered_column = start_location.last > ending_location.last
    misordered_row || misordered_column
  end

  def place_ship(ship, start_location, ending_location)
    locations = get_locations(start_location, ending_location)
    if valid_placement?(ship, start_location, ending_location)
      locations.each do |location|
        @board.add_ship(ship, location)
      end
    else
      []
    end
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

  def valid_placement?(ship, start_location, ending_location)
    conditions = [shares_row_or_column?(ship, start_location, ending_location),
                  !out_of_bounds?(start_location, ending_location),
                  valid_length?(ship, start_location, ending_location)
                 ]
    answer_without_overlap = conditions.inject do |final_answer, condition|
      final_answer && condition
    end
    if !!answer_without_overlap
      answer_without_overlap && not_already_filled?(start_location, ending_location)
    else
      answer_without_overlap
    end
  end

  def not_already_filled?(start_location, ending_location)
    locations = get_locations(start_location, ending_location)
    locations.none? do |row, column|
      @board.cell(row, column).content
    end
  end

  def valid_length?(ship, starting_location, ending_location)
      locations = get_locations(starting_location, ending_location)
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
    same_row?(start_location, ending_location) || same_column?(start_location, ending_location)
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
