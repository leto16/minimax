require_relative './evaluate'

def minimax(field, depth, is_maximizing, alpha = -Float::INFINITY, beta = +Float::INFINITY)
  prev_player = is_maximizing ? PLAYER : AI_PLAYER
  score = evaluate(field, depth, prev_player)

  return score if score != 0

  return 0 if complete_field?(field)

  if is_maximizing
    best_val = -Float::INFINITY
    (0..2).each do |i|
      (0..2).each do |j|
        if field[i][j].nil?
          field[i][j] = AI_PLAYER_MARK

          curr_val = minimax(field, depth + 1, false, alpha, beta)

          field[i][j] = nil

          best_val = [curr_val, best_val].max
          alpha = [alpha, best_val].max

          break if alpha >= beta
        end
      end
    end
    return best_val
  end

  if !is_maximizing
    worst_val = Float::INFINITY
    (0..2).each do |i|
      (0..2).each do |j|
        if field[i][j].nil?
          field[i][j] = PLAYER_MARK

          curr_val = minimax(field, depth + 1, true, alpha, beta)

          field[i][j] = nil

          worst_val = [curr_val, worst_val].min
          beta = [worst_val, beta].min

          break if beta <= alpha
        end
      end
    end
    return worst_val
  end
end