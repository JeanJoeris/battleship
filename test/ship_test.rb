require './test/test_helper'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_ship_has_hit_points
    ship = Ship.new(2)
    assert_equal 2, ship.hp
  end

  def test_get_locations
    ship = Ship.new(3)
    starting_location = [0,0]
    ending_location = [0,2]
    assert_equal [[0, 0], [0, 1], [0,2]], ship.get_locations(starting_location, ending_location)
  end

  def test_same_row
    ship = Ship.new(3)
    start_location = [2,3]
    ending_location = [2,4]
    assert_equal true, ship.same_row?(start_location, ending_location)
  end

  def test_same_column
    ship = Ship.new(3)
    start_location = [4,3]
    ending_location = [2,3]
    assert_equal true, ship.same_column?(start_location, ending_location)
  end

  def test_ship_has_locations
    ship = Ship.new(3)
    assert_equal [], ship.locations
    ship.set_location([0,0], [0,2])
    assert_equal [[0, 0], [0, 1], [0,2]], ship.locations
  end

end
