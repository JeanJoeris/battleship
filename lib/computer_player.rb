require './lib/player'

class ComputerPlayer < Player

  def add_ship_randomly(ship)
    initial_ship_count = @ship_log.count
    board_size = @board.get_board.count
    while @ship_log.count == initial_ship_count
      ship_start = [rand(board_size), rand(board_size)]
      ship_end   = [rand(board_size), rand(board_size)]
      add_ship(ship, ship_start, ship_end)
    end
  end

  def hit_randomly(board)
    initial_shot_count = (@hit_history + @miss_history).count
    board_size = @board.get_board.count
    while (@hit_history + @miss_history).count == initial_shot_count
      shot_location = hit(board, rand(board_size), rand(board_size))
    end
    shot_location
  end



end
