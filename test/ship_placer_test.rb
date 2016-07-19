require './test/test_helper'
require "./lib/ship_placer"
require "./lib/game_board"
require "./lib/ship"

class ShipPlacerTest < Minitest::Test

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

  def test_place_ship
    board = GameBoard.new(4,4)
    ship = Ship.new(3)
    ship_placer = ShipPlacer.new(board)
    ship_placer.place_ship(ship, [0,2], [0,0])
    assert_equal ship, board.cell(0,0).content
    assert_equal ship, board.cell(0,1).content
    assert_equal ship, board.cell(0,2).content
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

end
