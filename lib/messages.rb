require './lib/grid_drawer'
require './lib/board_pos_to_index'
require 'pry'

module Messages

  def instructions
    puts "\n\nThis is the game of Battleship.\n"\
      "You and your opponent place ships on a grid, "\
      "and take turns attacking each other."\
      "\n\nThe grids are referenced by letter "\
      "for row, and number for column"\
      "\nA1, B3, etc."\
      "\n\nThe first person to destroy all their "\
      "oppnents ships wins."\
      "(p)lay or (q)uit?"
  end

  def game_introduction_text(difficulty)
    if difficulty == ("medium" || "m")
      board_limits = ["A1", "H8"]
    elsif difficulty == ("hard" || "h")
      board_limits = ["A1", "L12"]
    else
      board_limits = ["A1", "D4"]
    end
    puts "\n\n\n\n"\
    "You are the admiral of a fleet of "\
    "battle-ships, sailing a vast ocean of nil.\n\n"\
    "You approach a rival admiral"\
    "\nNaturally you attack.\n\n"\
    "What else are you going to do with a ship "\
    "specifically designed for battle?\n"\
    "(it's right there in the name)\n\n"\
    "\npress enter to continue"
    gets
    puts "The rival admiral hails you: \n"\
    "\"I have laid out my ships on my grid.\n"\
    "You now need to layout your ships on your grid.\n"\
    "The grids have #{board_limits.first} at "\
    "the top left and #{board_limits.last} at the bottom right.\"\n"\
    "\n\n"
  end

  def render_boards(human, computer)
    human_grid_drawer = GridDrawer.new(human.board.get_board.count)
    comp_grid_drawer = GridDrawer.new(computer.board.get_board.count)
    human_grid_drawer.read(human)
    comp_grid_drawer.read(computer)
    puts "This is your grid, the one "\
         "that your opponent hits\n"
    comp_grid_drawer.grid.each do |row|
      puts row.join
    end
    puts "\npress enter to continue"
    gets
    puts "This is your opponent's grid"
    human_grid_drawer.grid.each do |row|
      puts row.join
    end
    puts "take aim!"
  end

  def get_size_by_difficulty(difficulty)
    if difficulty.downcase == "medium"
      8
    elsif difficulty.downcase == "hard"
      12
    else
      4
    end
  end

  def shot_text(human_shot, comp_shot, human, computer)
    human_target_ship = computer.board.cell(human_shot.first, human_shot.last).content
    comp_target_ship = human.board.cell(comp_shot.first, comp_shot.last).content

    puts "\n"*8+"You shot at "\
        "#{BoardPosToIndex.new.convert_back(human_shot)}"

    if !human_target_ship
      puts "And it missed.\n"
    elsif human_target_ship.hp == 0
      puts "You have vanquished an enemy ship!\n"\
        "it sinks into the ocean of nil"
    elsif human.hit_history.include?(human_shot)
      puts "And it was a hit!\n"
    end

    puts "\nYour enemy shot at #{BoardPosToIndex.new.convert_back(comp_shot)}"
    if !comp_target_ship
      puts "And it missed.\n"
    elsif comp_target_ship.hp == 0
      puts "They have destroyed one of our vessels...\n"\
        "it sinks into the ocean of nil\n"
    elsif computer.hit_history.include?(comp_shot)
      puts "And it was a hit!\n"
    end
    puts "\nPress any key to continue and see the grids"
    gets
  end

  def game_over_text(human, counter)
    puts "\n\n" + "   Game over!  ".center(25, "-")
    if human.ship_log.count == 0
      puts "\n\n\nYour fleet has been devoured by "\
        "the ocean of nil"\
        "\nYou lose..."\
        "\n it took you #{counter} shots"
    else
      puts "\n" +
        ("\n" + " *" * 20 + "\n" + "* " * 20)*3 +
        "\nA winner is you!"\
        "\nYour exploits will be forever celebrated, "\
        "in ports across the ocean of nil."\
        "\n it took you #{counter} shots"
    end
  end
end
