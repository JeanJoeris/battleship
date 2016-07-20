require './test/test_helper'
require './lib/grid_drawer'
require './lib/game_board'
require './lib/ship'
require './lib/game'
require 'pry'

class GridDrawerTest < Minitest::Test

  def test_header
    header = "==============="
    assert_equal header, GridDrawer.new.header.join
  end

  def test_top_line
    top_line = ".  1  2  3  4  "
    assert_equal top_line, GridDrawer.new.first_row.join
  end

  def test_letter_row
    a_row = "A              "
    c_row = "C              "
    assert_equal a_row, GridDrawer.new.get_letter_row("a").join
    assert_equal c_row, GridDrawer.new.get_letter_row("C").join
  end

  def test_get_all_letter_rows
    a_row = "A              "
    b_row = "B              "
    c_row = "C              "
    d_row = "D              "
    letter_rows = [a_row, b_row, c_row, d_row]
    grid_letter_rows = GridDrawer.new.get_all_letter_rows
    letter_rows.each_with_index do |row, index|
      assert_equal row, grid_letter_rows[index].join
    end
  end

  def test_basic_grid
    expected_rows = ["===============",
                     ".  1  2  3  4  ",
                     "A              ",
                     "B              ",
                     "C              ",
                     "D              ",
                     "==============="
                    ]
    drawer = GridDrawer.new
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end

  def test_draw_larger_grid
    expected_rows = ["========================",
                     ".  1  2  3  4  5  6  7  ",
                     "A                       ",
                     "B                       ",
                     "C                       ",
                     "D                       ",
                     "E                       ",
                     "F                       ",
                     "G                       ",
                     "========================"
                    ]
    drawer = GridDrawer.new(7)
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end

  def test_largest_grid
    expected_rows = ["=======================================",
                     ".  1  2  3  4  5  6  7  8  9 10 11 12  ",
                     "A                                      ",
                     "B                                      ",
                     "C                                      ",
                     "D                                      ",
                     "E                                      ",
                     "F                                      ",
                     "G                                      ",
                     "H                                      ",
                     "I                                      ",
                     "J                                      ",
                     "K                                      ",
                     "L                                      ",
                     "======================================="
                    ]
    drawer = GridDrawer.new(12)
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end

  def test_read_game_state_to_drawing
    expected_rows = ["===============",
                     ".  1  2  3  4  ",
                     "A  M           ",
                     "B              ",
                     "C              ",
                     "D              "
                    ]
    game = Game.new
    game.human.hit(game.computer.board, 0, 0)
    drawer = GridDrawer.new
    drawer.read(game.human)
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end

  def test_reading_multiple_hit_game
    expected_rows = ["===============",
                     ".  1  2  3  4  ",
                     "A  M           ",
                     "B        M     ",
                     "C              ",
                     "D           M  ",
                     "==============="
                    ]
    game = Game.new
    game.human.hit(game.computer.board, 0, 0)
    game.human.hit(game.computer.board, 1, 2)
    game.human.hit(game.computer.board, 3, 3)
    drawer = GridDrawer.new
    drawer.read(game.human)
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end

  def test_reading_game_with_ships_and_hits
    expected_rows = ["===============",
                     ".  1  2  3  4  ",
                     "A  H     H     ",
                     "B        M     ",
                     "C              ",
                     "D           M  ",
                     "==============="
                    ]
    game = Game.new
    game.computer.add_ship(Ship.new(3), [0,0], [0,2])
    game.human.hit(game.computer.board, 0, 0)
    game.human.hit(game.computer.board, 0, 2)
    game.human.hit(game.computer.board, 1, 2)
    game.human.hit(game.computer.board, 3, 3)
    drawer = GridDrawer.new
    drawer.read(game.human)
    expected_rows.each_with_index do |row, index|
      assert_equal row, drawer.grid[index].join
    end
  end


end
