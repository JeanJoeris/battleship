require './test/test_helper'
require './lib/board_pos_to_index'

class HumanNotationToIndexTest < Minitest::Test

  def test_find_letter_index
    converter = HumanNotationToIndex.new
    assert_equal 0, converter.find_letter_index("a")
    assert_equal 2, converter.find_letter_index("c")
  end

  def test_convert_a1_to_00
    converter = HumanNotationToIndex.new
    assert_equal [0,0], converter.convert("a1")
  end

  def test_convert_another_board_pos
    converter = HumanNotationToIndex.new
    assert_equal [2,1], converter.convert("c2")
  end

  def test_case_insensitivity
    converter = HumanNotationToIndex.new
    assert_equal [3,3], converter.convert("D4")
  end
end
