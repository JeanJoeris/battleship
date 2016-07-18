require './test/test_helper'
require './lib/menu'
class MenuTest < Minitest::Test
  def test_menu_responds_to_play
    menu = Menu.new
    assert_respond_to menu, :play
  end

  def test_menu_responds_to_instructions
    menu = Menu.new
    assert_respond_to menu, :instructions
  end

  def test_responds_to_quit
    menu = Menu.new
    assert_respond_to menu, :quit
  end
end
