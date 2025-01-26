require 'pry-byebug'
class Knight
  def possible_moves(start)
    iteration = 0
    possible_moves = []
    x_moves = [2, 1, -1, -2, -2, -1, 1, 2]
    y_moves = [1, 2, 2, 1, -1, -2, -2, -1]
    while iteration < 8
      x_position = x_moves[iteration] + start[0]
      y_position = y_moves[iteration] + start[1]

      if (x_position >= 0 && x_position <= 7) && (y_position >= 0 && y_position <= 7)
        possible_moves << [x_position,
                           y_position]
      end
      iteration += 1
    end
    possible_moves
  end

  def path_finder(start, goal)
    makeable_moves = possible_moves(start)
    all_moves = {}
    all_moves[start] = 0
    move_count = 1
    until all_moves.key?(goal)
      makeable_moves.each { |move| all_moves[move] = move_count if all_moves[move].nil? }
      makeable_moves = []
      all_moves.each_key do |move_made|
        possible_moves(move_made).each do |move|
          makeable_moves << move if all_moves[move].nil? || all_moves[move] > move_count
        end
      end
      move_count += 1
    end
    all_moves
  end

  def knight_moves(start, goal)
    all_paths = path_finder(start, goal)
    puts "You've made it in #{all_paths[goal]} moves! Here's your path: "
    reverse_path(goal, start, all_paths)
    p goal
  end

  def reverse_path(goal, start, all_paths)
    return start if start == goal

    previous_moves = []
    possible_moves(goal).each do |move|
      previous_moves << move if !all_paths[move].nil? && all_paths[move] < all_paths[goal]
    end
    p reverse_path(previous_moves[0], start, all_paths)
    goal
  end
end

test = Knight.new
test.knight_moves([0, 0], [7, 7])
