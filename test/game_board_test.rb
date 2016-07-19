require './test/test_helper'
require './lib/game_board'
require './lib/ship'

class GameBoardTest < Minitest::Test

  def test_has_board_with_game_cells
    board = GameBoard.new(1, 1)
    assert_equal GameCell, board.cell(0,0).class
    assert_equal NilClass, board.cell(0,1).class
  end

  def test_different_dimension_board
    board = GameBoard.new(3,4)
    assert_equal GameCell, board.cell(2,3).class
    assert_equal GameCell, board.cell(1,1).class
    assert_equal NilClass, board.cell(3,3).class
  end

  def test_add_to_board
    board = GameBoard.new(4, 4)
    board.add_to_cell(2, 2, "a ship")
    assert_equal "a ship", board.cell(2, 2).content
  end

  def test_hit_cell
    board = GameBoard.new(4,4)
    assert_equal false, board.cell(2,2).hit?
    board.hit(2,2)
    assert_equal true, board.cell(2,2).hit?
    assert_equal false, board.cell(0,0).hit?
  end

  def test_hitting_again_changes_nothing
    board = GameBoard.new(4,4)
    board.hit(2,2)
    assert_equal true, board.cell(2,2).hit?
    board.hit(2,2)
    assert_equal true, board.cell(2,2).hit?
  end

  def test_add_ship_to_board
    board = GameBoard.new(4, 4)
    ship = Ship.new(3)
    board.add_ship(ship, [1,3], [3,3])
    assert_equal ship, board.cell(1,3).content
    assert_equal ship, board.cell(2,3).content
    assert_equal ship, board.cell(3,3).content
  end

  def test_hit_ship_on_board
    board = GameBoard.new(4, 4)
    ship = Ship.new(3)
    board.add_ship(ship, [1,3], [3,3])
    board.hit(1,3)
    assert_equal true, board.cell(1,3).hit?
    assert_equal 2, ship.hp
    board.hit(2,3)
    assert_equal 1, ship.hp
    board.hit(3,3)
    assert_equal 0, ship.hp
    board.hit(3,3)
    assert_equal 0, ship.hp
  end

  def test_cannot_hit_same_ship_square_twice
    board = GameBoard.new(4, 4)
    ship = Ship.new(3)
    board.add_ship(ship, [1,3], [3,3])
    board.hit(2,3)
    assert_equal 2, ship.hp
    board.hit(2,3)
    assert_equal 2, ship.hp
    board.hit(1,3)
    board.hit(1,3)
    assert_equal 1, ship.hp
  end

  def test_knows_locations_of_shots
    
  end

  # def test_board_has_ship_count
  #   board = GameBoard.new(4,4)
  #   ship_1 = Ship.new(3)
  #   ship_2 = Ship.new(4)
  #   board.add_ship
  # end

end
