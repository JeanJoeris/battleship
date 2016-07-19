require './test/test_helper'
require './lib/game'
require './lib/ship'
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

  def test_largest_size
    game = Game.new("HARD")
    assert_equal 12**2, game.player_board.get_board.flatten.count
  end

  def test_shoot_specific_board
    game = Game.new
    game.shoot(game.computer_board, 0, 0)
    assert_equal true, game.computer_board.cell(0,0).hit?
  end

  def test_miss_history
    game = Game.new
    game.shoot(game.computer_board, 0, 0)
    assert_equal [[0,0]], game.miss_history[game.computer_board]
    game.shoot(game.computer_board, 1, 1)
    assert_equal [[0,0], [1,1]], game.miss_history[game.computer_board]
  end

  def test_hit_history
    game = Game.new
    game.computer_board.add_ship(Ship.new(3), [0,0], [0,2])
    game.computer_board.add_ship(Ship.new(2), [1,1], [1,2])
    game.shoot(game.computer_board, 0, 0)
    assert_equal [[0,0]], game.hit_history[game.computer_board]
    game.shoot(game.computer_board, 1, 1)
    game.shoot(game.computer_board, 2, 2)
    assert_equal [[0,0], [1,1]], game.hit_history[game.computer_board]
    assert_equal [[2,2]], game.miss_history[game.computer_board]
  end

  def test_ship_log
    game = Game.new
    ship_1 = Ship.new(2)
    ship_2 = Ship.new(3)
    game.add_ship(game.computer_board, ship_1, [0,2], [0,1])
    game.add_ship(game.computer_board, ship_2, [1,3], [3,3])
    assert_equal [ship_1, ship_2], game.ship_log[game.computer_board]
  end

  def test_hitting_ships_reduces_hp_in_log
    game = Game.new
    ship_1 = Ship.new(2)
    ship_2 = Ship.new(3)
    game.add_ship(game.computer_board, ship_1, [0,2], [0,1])
    game.add_ship(game.computer_board, ship_2, [1,3], [3,3])
    game.shoot(game.computer_board, 0, 0)
    assert_equal 2, ship_1.hp
    assert_equal 2, game.ship_log[game.computer_board].first.hp
  end
end
