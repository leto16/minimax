def horizontal_end?
  res = $field.any? { |row| (row[0] != nil) && (row[0] == row[1]) && (row[1] == row[2]) }
end

def vertical_end?
  (0..2).any? do |i| 
    ($field[0][i] != nil) &&
    ($field[0][i] == $field[1][i]) &&
    ($field[1][i] == $field[2][i])
  end
end

def diagonal_end?
  ($field[1][1] != nil) && 
  (
    (($field[0][0] == $field[1][1]) && ($field[1][1] == $field[2][2])) ||
    (($field[2][0] == $field[1][1]) && ($field[1][1] == $field[0][2]))
  )
end

def complete_field?(field)
  field.all? { |row| row.none?(&:nil?) }
end

def end_of_the_game?
  horizontal_end? || vertical_end? || diagonal_end?
end

def evaluate(field, depth, acting_player)
  if end_of_the_game?
    if acting_player == AI_PLAYER
      return 100 - depth
    elsif acting_player == PLAYER
      return -100 - depth
    end
  end

  return 0
end