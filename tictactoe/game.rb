require_relative './board_drawer'
require 'io/console'

PLAYER = :player
AI_PLAYER = :ai_player
PLAYER_MARK = :x
AI_PLAYER_MARK = :o

$current_player = AI_PLAYER
$field = nil
$end_of_game = nil
$winner = nil

$algorithm_stats = []

require_relative './algorithms/minimax_with_a_b'
# require_relative './algorithms/minimax'

def starting_field
  [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
end

def best_move
  hypthetical_field = $field
  best_val = -Float::INFINITY
  best_move = { i: -1, j: -1 }
  available_cells = $field.reduce(0) { |acc, row| acc + row.count(nil) }

  (0..2).each do |i|
    (0..2).each do |j|
      if hypthetical_field[i][j].nil?
        hypthetical_field[i][j] = AI_PLAYER_MARK

        t1 = Time.now
        curr_val = minimax(hypthetical_field, 0, false)
        t2 = Time.now - t1
        $algorithm_stats.push({ available_cells: available_cells, time: t2 })

        hypthetical_field[i][j] = nil
        if curr_val > best_val
          best_val = curr_val
          best_move[:i], best_move[:j] = i, j
        end
      end
    end
  end

  best_move
end

def available_cells
  $field.map.with_index do |row, i|
    row.each_with_index.reduce([]) { |acc, (cell, j)| cell.nil? ? (acc << (i*3)+j+1) : acc}
  end.flatten
end

def make_move
  if $current_player == AI_PLAYER
    move = best_move
    $field[move[:i]][move[:j]] = AI_PLAYER_MARK
  else
    puts ''
    print "Choose your move: "
    while !available_cells.include?(choise = STDIN.getch.to_i)
      print "Please choose among available moves (#{available_cells.join(', ')}): "
    end
    $field[((choise-1) / 3)][choise % 3 - 1] = PLAYER_MARK
  end
end

def reprint_field
  BoardDrawer.new($field).paint
end

def assign_player
  $current_player == AI_PLAYER ? $current_player = PLAYER : $current_player = AI_PLAYER
end

def check_end_game
  # horizontal win check
  if end_of_the_game?
    $end_of_game = true
    $winner = $current_player
  end

  $end_of_game = true if complete_field?($field)
end

def print_winner
  case $winner
  when PLAYER
    puts 'You won!'
  when AI_PLAYER
    puts 'AI won!'
  when :friendship
    puts 'Tie!'
  end
end

def finish_game
  puts "........................."
  puts "====STATS===="
  puts $algorithm_stats
  puts "........................."
  puts "Press any key to continue"
  STDIN.getch
end

def start_game
  $field = starting_field
  $end_of_game = false
  $winner = :friendship
  $algorithm_stats = []

  reprint_field
  loop do
    make_move
    system "clear"
    reprint_field
    check_end_game

    break if $end_of_game
    assign_player
  end
  print_winner
  finish_game
end

def start_app
  loop do
    system "clear"
    puts "Who starts? (Press 3 for exit)"
    print "1 - AI (o), 2 - You (x): "
    while ![1, 2, 3].include?(choise = STDIN.getch.to_i)
      print "\n1 - AI, 2 - You: "
    end
    break if choise == 3
    choise == 1 ? $current_player = AI_PLAYER : $current_player = PLAYER
    puts "\n\n"

    start_game
  end
end

start_app
