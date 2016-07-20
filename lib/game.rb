require './lib/game_board'
require './lib/human_player'
require './lib/computer_player'
require './lib/grid_drawer'
require './lib/board_pos_to_index'

class Game
  attr_reader :human,
              :computer

  def initialize(difficulty = "easy")
    @difficulty = difficulty
    size = get_size_by_difficulty(@difficulty)
    human_board = GameBoard.new(size, size)
    computer_board = GameBoard.new(size, size)
    @human = HumanPlayer.new(human_board)
    @computer = ComputerPlayer.new(computer_board)
    @comp_grid_drawer = GridDrawer.new(size)
    @human_grid_drawer = GridDrawer.new(size)
    @converter = BoardPosToIndex.new
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

  def game_over?
    human_dead = @human.ship_log.all? do |ship|
      ship.hp == 0
    end
    computer_dead = @computer.ship_log.all? do |ship|
      ship.hp == 0
    end
    human_dead || computer_dead
  end

  def starting_human_ships
    default_ships = [Ship.new(2), Ship.new(3)]
    if @difficulty == "medium"
      default_ships << Ship.new(4)
    elsif @difficulty == "hard"
      default_ships << Ship.new(4)
      default_ships << Ship.new(5)
    end
    default_ships
  end

  def starting_computer_ships
    default_ships = [Ship.new(2), Ship.new(3)]
    if @difficulty == "medium"
      default_ships << Ship.new(4)
    elsif @difficulty == "hard"
      default_ships << Ship.new(4)
      default_ships << Ship.new(5)
    end
    default_ships
  end

  def add_starting_ships
    starting_human_ships.each_with_index do |ship, index|
      human.add_legal_ship(ship)
      computer.add_ship_randomly(starting_computer_ships[index])
    end
  end

  def turn_sequence(counter)
    puts "this is the #{counter} round"
    human_shot = human.enter_legal_shot(computer.board)
    comp_shot = computer.hit_randomly(human.board)
    puts "You shot at #{@converter.convert_back(human_shot)}"
    puts "The computer shot at #{@converter.convert_back(comp_shot)}"
    if computer.hit_history.include?(comp_shot)
      puts "And it was a hit!"
    else
      puts "And it missed."
    end
    counter += 1
  end

  def main_loop
    add_starting_ships
    counter = 0
    until game_over?
      turn_sequence(counter)
      @comp_grid_drawer.read(@human)
      @human_grid_drawer.read(@computer)
      puts "This is the computer's grid"
      @comp_grid_drawer.grid.each do |row|
        puts row.join
      end
      puts "\nThis is the human's grid"
      @human_grid_drawer.grid.each do |row|
        puts row.join
      end
    end
    puts "\n\n Game over"
    if human.ship_log.count == 0
      puts "You lost, too bad..."
    else
      puts "A winner is you!"
    end
  end

end
