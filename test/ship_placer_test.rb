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
