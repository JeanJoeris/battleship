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

end
