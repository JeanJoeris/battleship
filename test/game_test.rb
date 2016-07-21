require './test/test_helper'
require './lib/game'
require './lib/ship'
class GameTest < Minitest::Test

  def test_has_human_and_computer
    game = Game.new
    assert_respond_to game, :human, :computer
  end

  def test_game_has_two_game_boards
    game = Game.new()
    assert_equal 16, game.human.board.get_board.flatten.count
    assert_equal 16, game.computer.board.get_board.flatten.count
  end

  def test_game_has_correct_size_for_other_difficulties
    game = Game.new("medium")
    assert_equal 64, game.human.board.get_board.flatten.count
  end

  def test_default_size
    game = Game.new("nightmare")
    assert_equal 16, game.computer.board.get_board.flatten.count
  end

  def test_largest_size
    game = Game.new("HARD")
    assert_equal 12**2, game.human.board.get_board.flatten.count
  end

  def test_easy_starting_ships
    game = Game.new
    starting_ships = game.starting_human_ships
    correct_ship_hp = [2,3]
    correct_ship_hp.each_with_index do |ship_hp, index|
      assert_equal ship_hp, starting_ships[index].hp
    end
  end

  def test_med_starting_ships
    game = Game.new("medium")
    starting_ships = game.starting_computer_ships
    correct_ship_hp = [2, 3, 4]
    correct_ship_hp.each_with_index do |ship_hp, index|
      assert_equal ship_hp, starting_ships[index].hp
    end
  end

  def test_hard_starting_ships
    game = Game.new("hard")
    starting_ships = game.starting_human_ships
    correct_ship_hp = [2, 3, 4, 5]
    correct_ship_hp.each_with_index do |ship_hp, index|
      assert_equal ship_hp, starting_ships[index].hp
    end
  end

  def test_can_shoot_each_other
    skip # because it requires human interaction
    game = Game.new
    game.human.enter_legal_shot(game.computer.board)
    game.computer.hit_randomly(game.human.board)
    assert_equal 1, game.human.miss_history.count
    assert_equal 1, game.computer.miss_history.count
  end

  def test_can_actually_hit_each_other
    skip # because it requires human interaction
    game = Game.new
    game.computer.add_ship(Ship.new(2), [0,0], [0,1])
    game.human.enter_legal_shot(game.computer.board)
    game.computer.hit_randomly(game.human.board)
    assert_equal 1, game.human.hit_history.count
    assert_equal 1, game.computer.miss_history.count
    assert_equal 1, game.computer.board.cell(0,0).content.hp
    assert_equal 1, game.computer.ship_log.first.hp
  end

  def test_game_over
    game = Game.new
    game.computer.add_ship(Ship.new(2), [0,0], [0,1])
    game.human.add_ship(Ship.new(3), [0,0], [0,2])
    assert_equal false, game.game_over?
    game.computer.board.hit(0,0)
    game.computer.board.hit(0,1)
    assert_equal true, game.game_over?
  end

  def test_main_loop
    skip # because it requires human interaction
    game = Game.new("easy")
    game.main_loop
    assert_respond_to game, :main_loop

  end
end
