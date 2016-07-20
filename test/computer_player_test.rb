require './test/test_helper'
require './lib/computer_player'
require './lib/game_board'

class ComputerPlayerTest < Minitest::Test

  # to test random behavior I checked counts
  # and pry-ed in to check things were changing

  def test_has_board_shot_history_and_ship_log
    board = GameBoard.new(4,4)
    comp = ComputerPlayer.new(board)
    assert_equal board, comp.board
    assert_equal [], comp.miss_history
    assert_equal [], comp.hit_history
    assert_equal [], comp.ship_log
  end

  def test_random_ship_placer
    board = GameBoard.new(12,12)
    comp = ComputerPlayer.new(board)
    ship = Ship.new(3)
    comp.add_ship_randomly(ship)
    assert_equal 1, comp.ship_log.count
    comp.add_ship_randomly(Ship.new(4))
    assert_equal 2, comp.ship_log.count
  end

  def test_random_shot
    board = GameBoard.new(2,2)
    comp = ComputerPlayer.new(board)
    3.times do
      comp.hit_randomly(comp.board)
    end
    assert_equal 3 , comp.miss_history.count
  end

end
