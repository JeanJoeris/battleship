require './lib/game_board'
require './lib/human_player'
require './lib/computer_player'
require './lib/grid_drawer'
require './lib/board_pos_to_index'
require './lib/messages'

class Game
  include Messages
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
    @counter = 1
    @timer = Time.new
  end

  def main_loop
    game_introduction_text(@difficulty)
    add_starting_ships
    until game_over?
      render_boards(@human, @computer)
      turn_sequence
    end
    game_over_text(@human, @counter, @timer)
  end

  def add_starting_ships
    starting_human_ships.each_with_index do |ship, index|
      human.add_legal_ship(ship)
      computer.add_ship_randomly(starting_computer_ships[index])
    end
  end

  def turn_sequence
    puts "this is round #{@counter}"
    human_shot = human.enter_legal_shot(computer.board)
    comp_shot = computer.hit_randomly(human.board)
    shot_text(human_shot, comp_shot, @human, @computer)
    @counter += 1
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

end
