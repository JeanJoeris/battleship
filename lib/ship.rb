require 'pry'

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

  def set_location(*location_cells)
    location_cells.each do |cell|
      @locations << cell
    end
  end

  

end
