require './test/test_helper'
require './lib/board_pos_to_index'

class BoardPosToIndexTest < Minitest::Test

  def test_convert_a1_to_00
    converter = BoardPosToIndex.new
    assert_equal [0,0], converter.convert("a1")
  end

  def test_convert_another_board_pos
    converter = BoardPosToIndex.new
    assert_equal [2,1], converter.convert("c2")
  end

  def test_case_insensitivity
    converter = BoardPosToIndex.new
    assert_equal [3,3], converter.convert("D4")
  end

  def test_convert_back
    converter = BoardPosToIndex.new
    assert_equal "a1", converter.convert_back([0,0])
    assert_equal "d6", converter.convert_back([3,5])
  end
end
