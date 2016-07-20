require './test/test_helper'
require './lib/game_board'
require './lib/ship'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_has_board
    board = GameBoard.new(4,4)
    player = Player.new(board)
    assert_equal board, player.board
  end

  def test_player_has_miss_log
    board = GameBoard.new(4,4)
    player = Player.new(board)
    player.hit(0,0)
    assert_equal [[0,0]], player.miss_history
  end

  def test_player_has_hit_log
    board = GameBoard.new(4,4)
    player = Player.new(board)
    ship = Ship.new(1)
    board.add_ship(ship, [0,0])
    player.hit(0,0)
    player.hit(1,1)
    assert_equal [[0,0]], player.hit_history
    assert_equal [[1,1]], player.miss_history
  end

  def test_has_ship_log
    board = GameBoard.new(4,4)
    player = Player.new(board)
    assert_equal [], player.ship_log
  end

  def test_add_ships
    board = GameBoard.new(4,4)
    player = Player.new(board)
    ship = Ship.new(2)
    player.add_ship(ship, [1,1], [1,2])
    assert_equal ship, player.board.cell(1,1).content
  end

  def test_ship_log_has_added_ships
    board = GameBoard.new(4,4)
    player = Player.new(board)
    ship = Ship.new(2)
    ship_2 = Ship.new(3)
    player.add_ship(ship, [1,1], [1,2])
    assert_equal [ship], player.ship_log
    player.add_ship(ship_2, [2,1], [2,3])
    assert_equal [ship, ship_2], player.ship_log
  end

  def test_hitting_ships_reduces_hp_in_log
    board = GameBoard.new(4,4)
    player = Player.new(board)
    ship = Ship.new(2)
    ship_2 = Ship.new(3)
    player.add_ship(ship, [1,1], [1,2])
    player.add_ship(ship_2, [2,1], [2,2], [2,3])
    player.hit(2,1)
    player.hit(2,2)
    player.hit(0,0)
    assert_equal 2, ship.hp
    assert_equal 2, player.ship_log.first.hp
    assert_equal 1, ship_2.hp
    assert_equal 1, player.ship_log.last.hp
  end

end
