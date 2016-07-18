class Ship
  attr_reader :hp,
              :locations

  def initialize(size)
    @hp = size
    @locations = []
  end

  def hit
    @hp -= 1 if hp > 0
  end

  def set_location(starting_location, ending_location)
    @locations = get_locations(starting_location, ending_location)
  end

  def get_locations(start_location, ending_location)
    locations = []
    range = get_cell_range(start_location, ending_location)
    range.each do |num|
      if same_row?(start_location, ending_location)
        locations << [start_location[0], num]
      elsif same_column?(start_location, ending_location)
        locations << [num, start_location[1]]
      end
    end
    locations
  end

  def get_cell_range(start_location, ending_location)
    if same_row?(start_location, ending_location)
      same_row = true
      range = (start_location[1]..ending_location[1])
    elsif same_column?(start_location, ending_location)
      same_column = false
      range = (start_location[0]..ending_location[0])
    end
  end

  def same_row?(start_location, ending_location)
    start_location[0] == ending_location[0]
  end

  def same_column?(start_location, ending_location)
    start_location[1] == ending_location[1]
  end

end
