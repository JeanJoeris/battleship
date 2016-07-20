class GridDrawer
  attr_reader :grid

  def initialize(length = 4)
    @board_length = length
    @grid = grid_init
  end

  def grid_init
    starting_grid = get_all_letter_rows
    starting_grid.unshift(first_row)
    starting_grid.unshift(header)
    starting_grid.push(header)
  end

  def header
    row_array = ["=="]
    @board_length.times do
      row_array << "==="
    end
    row_array << "="
  end

  def first_row
    row_array = [". "]
    @board_length.times do |num|
      row_array << "#{num+1}".center(3)
    end
    row_array << " "
  end

  def get_letter_row(letter)
    row_array = ["#{letter.upcase} "]
    @board_length.times do
      row_array << "   "
    end
    row_array << " "
  end

  def get_all_letter_rows
    last_letter = ("a".ord + (@board_length-1)).chr
    ("a"..last_letter).map do |letter|
      get_letter_row(letter)
    end
  end

  def read(player)
    # binding.pry
    player.miss_history.each do |row, column|
      @grid[row + 2][column + 1][1] = "M"
    end
    player.hit_history.each do |row, column|
      @grid[row + 2][column + 1][1] = "H"
    end
  end

end
