require './test/test_helper'
require './lib/grid_drawer'

class GridDrawerTest < Minitest::Test

  def test_basic_grid
    expected_rows = [["==========="],
                     [". 1 2 3 4  "],
                     ["A          "],
                     ["B          "],
                     ["C          "],
                     ["D          "]
                    ]
    drawer = GridDrawer.new
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index]
    end
  end

end
