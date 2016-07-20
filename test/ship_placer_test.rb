require './test/test_helper'
require "./lib/ship_placer"
require "./lib/game_board"
require "./lib/ship"

class ShipPlacerTest < Minitest::Test

  def test_get_locations
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    starting_location = [0,0]
    ending_location = [0,2]
    assert_equal [[0, 0], [0, 1], [0,2]], ship_placer.get_locations(starting_location, ending_location)
  end

  def test_same_row
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    start_location = [2,3]
    ending_location = [2,4]
    assert_equal true, ship_placer.same_row?(start_location, ending_location)
  end

  def test_same_column
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    start_location = [0,0]
    ending_location = [2,0]
    assert_equal true, ship_placer.same_column?(start_location, ending_location)
  end

  def test_says_valid_placement_is_valid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    assert_equal true, ship_placer.valid_placement?(ship, [0,0], [2,0])
  end

  def test_says_diagonal_placement_is_invalid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    assert_equal false, ship_placer.valid_placement?(ship, [0,0], [1,1])
  end

  def test_unordered_placement_is_still_valid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    assert_equal true, ship_placer.valid_placement?(ship, [2,0], [0,0])
    assert_equal true, ship_placer.valid_placement?(ship, [0,2], [0,0])
  end

  def test_out_of_bounds
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    assert_equal false, ship_placer.out_of_bounds?([0,0])
    assert_equal true, ship_placer.out_of_bounds?([4,4])
    assert_equal true, ship_placer.out_of_bounds?([-1,0])
  end

  def test_out_of_bounds_multi_input
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    assert_equal false, ship_placer.out_of_bounds?([0,0], [2,2])
    assert_equal true, ship_placer.out_of_bounds?([0,0], [-1,4])
  end

  def test_one_location_out_of_bounds_is_invalid
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    assert_equal false, ship_placer.valid_placement?(ship, [3,0], [4, 0])
    assert_equal false, ship_placer.valid_placement?(ship, [3,3], [3, -20])
  end

  def test_not_already_filled
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    assert_equal true, ship_placer.not_already_filled?([0,0], [0,1])
  end

  def test_not_already_filled_on_square
    board = GameBoard.new(4,4)
    ship_placer = ShipPlacer.new(board)
    ship = Ship.new(3)
    ship_placer.place_ship(ship, [0,1], [2,1])
    assert_equal false, ship_placer.not_already_filled?([0,0], [0,2])
    assert_equal false, ship_placer.not_already_filled?([2,0], [2,2])
  end

  def test_place_ship
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    ship_placer.place_ship(ship, [0,2], [0,0])
    assert_equal ship, board.cell(0,0).content
    assert_equal ship, board.cell(0,1).content
    assert_equal ship, board.cell(0,2).content
  end

  def test_place_ship_updates_ship_locations
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    ship_placer.place_ship(ship, [0,2], [0,0])
    assert_equal [[0,0], [0,1], [0,2]], ship.locations
  end

  def test_place_invalid_ship
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    assert_equal [], ship_placer.place_ship(ship, [0,0], [1,2])
    assert_equal nil, board.cell(0,0).content
  end

  def test_place_ship_with_invalid_length
    board = GameBoard.new(4,4)
    ship = Ship.new(2)
    ship_placer = ShipPlacer.new(board)
    assert_equal [], ship_placer.place_ship(ship, [0,0], [0,2])
    assert_equal nil, board.cell(0,0).content
  end

  def test_place_ship_on_occupied_square
    board = GameBoard.new(4,4)
    ship_1 = Ship.new(3)
    ship_2 = Ship.new(2)
    ship_placer = ShipPlacer.new(board)
    ship_placer.place_ship(ship_1, [0,2], [0,0])
    assert_equal ship_1, board.cell(0,0).content
    assert_equal [], ship_placer.place_ship(ship_2, [0,0], [1,0])
    assert_equal ship_1, board.cell(0,0).content
  end

end
