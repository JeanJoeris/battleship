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
    puts "getting a game ready"
  end

  def instructions
    puts "it's battleship"
  end

  def quit
    @has_quit = true
  end

end

# menu = Menu.new
# menu.main_loop
