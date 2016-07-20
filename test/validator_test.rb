require './test/test_helper'
require './lib/validator'
require './lib/game_board'
require './lib/ship'

class ValidatorTest < Minitest::Test

  def test_same_row
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    start_location = [2,3]
    ending_location = [2,4]
    assert_equal true, validator.same_row?(start_location, ending_location)
  end

  def test_same_column
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    start_location = [0,0]
    ending_location = [2,0]
    assert_equal true, validator.same_column?(start_location, ending_location)
  end

  def test_says_valid_placement_is_valid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    validator = Validator.new(board)
    assert_equal true, validator.valid_placement?(ship, [0,0], [2,0])
  end

  def test_says_diagonal_placement_is_invalid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    validator = Validator.new(board)
    assert_equal false, validator.valid_placement?(ship, [0,0], [1,1])
  end

  def test_unordered_placement_is_still_valid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    validator = Validator.new(board)
    assert_equal true, validator.valid_placement?(ship, [2,0], [0,0])
    assert_equal true, validator.valid_placement?(ship, [0,2], [0,0])
  end

  def test_out_of_bounds
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    assert_equal false, validator.out_of_bounds?([0,0])
    assert_equal true, validator.out_of_bounds?([4,4])
    assert_equal true, validator.out_of_bounds?([-1,0])
  end

  def test_out_of_bounds_multi_input
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    assert_equal false, validator.out_of_bounds?([0,0], [2,2])
    assert_equal true, validator.out_of_bounds?([0,0], [-1,4])
  end

  def test_one_location_out_of_bounds_is_invalid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    validator = Validator.new(board)
    assert_equal false, validator.valid_placement?(ship, [3,0], [4, 0])
    assert_equal false, validator.valid_placement?(ship, [3,3], [3, -20])
  end

  def test_not_already_filled
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    assert_equal true, validator.not_already_filled?([0,0], [0,1])
  end

  def test_not_already_filled_on_square
    board = GameBoard.new(4,4)
    validator = Validator.new(board)
    ship = Ship.new(3)

    validator.board.add_ship(ship, [0,1], [1,2], [2,1])
    assert_equal false, validator.not_already_filled?([0,0], [0,2])
    assert_equal false, validator.not_already_filled?([2,0], [2,2])
  end

end
