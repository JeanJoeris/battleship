require './test/test_helper'
require './lib/game'
class GameTest < Minitest::Test

  def test_game_has_two_game_boards
    game = Game.new("Easy")
    assert_equal 16, game.player_board.get_board.flatten.count
    assert_equal 16, game.computer_board.get_board.flatten.count

  end

  def test_game_has_correct_size_for_other_difficulties
    game = Game.new("medium")
    assert_equal 64, game.player_board.get_board.flatten.count
  end

  def test_default_size
    game = Game.new("nightmare")
    assert_equal 16, game.computer_board.get_board.flatten.count
  end

  def test_large_size
    game = Game.new("HARD")
    assert_equal 12**2, game.player_board.get_board.flatten.count
  end

end
