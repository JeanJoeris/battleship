require './test/test_helper'
require './lib/human_player'
require './lib/game_board'

class HumanPlayerTest < Minitest::Test

  def test_responds_to_add_legal_ship
    board = GameBoard.new(4,4)
    human = HumanPlayer.new(board)
    assert_respond_to human, :add_legal_ship
  end

  def test_responds_to_enter_legal_shot
    board = GameBoard.new(4,4)
    human = HumanPlayer.new(board)
    assert_respond_to human, :enter_legal_shot
  end

  def test_is_valid_input
    board = GameBoard.new(4,4)
    human = HumanPlayer.new(board)
    assert_equal true, human.is_valid_input?("a1")
  end

  def test_invalid_input_is_invalid
    board = GameBoard.new(4,4)
    human = HumanPlayer.new(board)
    assert_equal false, human.is_valid_input?("foo")
    assert_equal false, human.is_valid_input?(" ")
    assert_equal false, human.is_valid_input?("")
    assert_equal false, human.is_valid_input?("aa")
    assert_equal false, human.is_valid_input?("11")
  end

end
