require './test/test_helper'
require './lib/game_cell.rb'
class GameCellTest < Minitest::Test
  def test_game_cell_has_content_and_hit_state
    cell = GameCell.new
    assert_equal nil, cell.content
    assert_equal false, cell.hit?
  end

  def test_hit_cell
    cell = GameCell.new
    cell.hit
    assert_equal true, cell.hit?
  end

  def test_hit_cell_again_changes_nothing
    cell = GameCell.new
    cell.hit
    assert_equal true, cell.hit?
    cell.hit
    assert_equal true, cell.hit?
  end

  def test_add_content
    cell = GameCell.new
    cell.add("a ship")
    assert_equal "a ship", cell.content
  end

  def test_cannot_add_content_if_already_added_to
    cell = GameCell.new
    cell.add("a ship")
    cell.add("another ship")
    assert_equal "a ship", cell.content
  end
end
