require './lib/game'

class Menu

  def initialize
    @has_quit = false
  end

  def main_loop
    puts "Welcome to Battleship!\n"
    puts "Would you like to (p)lay, get (i)nstructions, or (q)uit?\n"
    until @has_quit do
      input = gets.chomp
      if input == "p" || input ==  "play"
        play
      elsif input == "i" || input ==  "instructions"
        instructions
      elsif input == "q" || input =="quit"
        return @has_quit = true
      else
        puts "please chose again"
      end
    end
  end

  def play
    puts "what difficulty? (e)asy, (m)edium, or (h)ard?"
    difficulty_select = gets.chomp
    if difficulty_select == "m"
      game = Game.new("medium")
    elsif difficulty_select == "h"
      game = Game.new("hard")
    else
      game = Game.new("easy")
    end
    game.main_loop
    puts "Thanks for playing, chose p, i or q"
  end

  def instructions
    puts "it's battleship"
  end

  def quit
    @has_quit = true
  end

end

menu = Menu.new
menu.main_loop
