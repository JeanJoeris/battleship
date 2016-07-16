require './test/test_helper'
require './lib/game_board.rb'

class GameBoardTest < Minitest::Test

  def test_has_board_with_game_cells
    board = GameBoard.new(1, 1)
    assert_equal GameCell, board.board(0,0).class
    assert_equal NilClass, board.board(0,1).class
  end

  def test_different_dimension_board
    board = GameBoard.new(3,4)
    assert_equal GameCell, board.board(2,3).class
    assert_equal GameCell, board.board(1,1).class
    assert_equal NilClass, board.board(3,3).class
  end

  def test_add_to_board
    board = GameBoard.new(4, 4)
    board.add_to_cell(2, 2, "a ship")
    assert_equal "a ship", board.board(2, 2).content
  end

end
