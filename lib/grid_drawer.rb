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
  end

  def header
    row_array = ["=="]
    @board_length.times do
      row_array << "=="
    end
    row_array << "="
  end

  def first_row
    row_array = [". "]
    @board_length.times do |num|
      row_array << "#{num+1} "
    end
    row_array << " "
  end

  def get_letter_row(letter)
    row_array = ["#{letter.upcase} "]
    @board_length.times do
      row_array << "  "
    end
    row_array << " "
  end

  def get_all_letter_rows
    last_letter = ("a".ord + (@board_length-1)).chr
    ("a"..last_letter).map do |letter|
      get_letter_row(letter)
    end
  end

  def read(board)
    found_hit_columns = board.get_board.map do |row|
      row.find_index do |column|
        column.hit? == true
      end
    end
    found_hit_columns.each_with_index do |column_index, row_index|
      if column_index
        if board.cell(row_index, column_index).content
          @grid[row_index + 2][column_index + 1] = "H "
        else
          @grid[row_index + 2][column_index + 1] = "M "
        end
      end
    end
  end

end
