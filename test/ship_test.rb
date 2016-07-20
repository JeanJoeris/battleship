require './test/test_helper'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_ship_has_hit_points
    ship = Ship.new(2)
    assert_equal 2, ship.hp
  end

  def test_ship_has_locations
    ship = Ship.new(3)
    assert_equal [], ship.locations
    ship.set_location([0,0], [0,1], [0,2])
    assert_equal [[0, 0], [0, 1], [0,2]], ship.locations
  end

  def test_hit_ship_decreases_hp
    ship = Ship.new(2)
    ship.hit
    assert_equal 1, ship.hp
    ship.hit
    assert_equal 0, ship.hp
    ship.hit
    assert_equal 0, ship.hp
  end

end
