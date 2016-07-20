require './lib/ship_placer'

class Validator

  attr_reader :board

  def initialize(board)
    @board = board
    @ship_placer = ShipPlacer.new(@board)
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
    answer_without_overlap = conditions.inject(:&)
    if !!answer_without_overlap
      answer_without_overlap && not_already_filled?(start_location, ending_location)
    else
      answer_without_overlap
    end
  end

  def not_already_filled?(start_location, ending_location)
    locations = @ship_placer.get_locations(start_location, ending_location)
    locations.none? do |row, column|
      @board.cell(row, column).content
    end
  end

  def valid_length?(ship, starting_location, ending_location)
      locations = @ship_placer.get_locations(starting_location, ending_location)
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
