require './lib/game'
require './lib/messages'

class Menu
  include Messages

  def initialize
    @has_quit = false
  end

  def main_loop
    game_open_text
    puts "Would you like to (p)lay, get (i)nstructions, or (q)uit?\n"
    until @has_quit do
      input = gets.chomp
      select_input(input)
    end
  end

  def select_input(input)
    if input == ("p" || "play")
      play
    elsif input == ("i" || "instructions")
      instructions
    elsif input == ("q" || "quit")
      return @has_quit = true
    else
      puts "please chose again"
    end
  end

  def play
    puts "what difficulty? (e)asy, (m)edium, or (h)ard?"
    difficulty_select = gets.chomp
    if difficulty_select == ("m" || "medium")
      game = Game.new("medium")
    elsif difficulty_select == ("h" || "hard")
      game = Game.new("hard")
    else
      game = Game.new("easy")
    end
    game.main_loop
    puts "Thanks for playing, chose (p)lay, (i)nstructions or (q)uit"
  end

  def quit
    @has_quit = true
  end

end
