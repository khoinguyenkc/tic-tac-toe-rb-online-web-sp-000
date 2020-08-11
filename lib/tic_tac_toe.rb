# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
#it's a constant as in it can be accessed by methods. usual variables can't be accessed and must be passed into the method

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    # if same value in this row/column/diag and not empty empty empty
    if ( (board[combo[0]] == board[combo[1]]) &&  (board[combo[1]] == board[combo[2]] ) && position_taken?(board, combo[0]) )
      return combo
    #critical:
    #do not put an else return nil here. or it will end the entire operation. only return nill if it's looped through EVERYTHING and still found nothing
    end
  end

  return nil
end

#hi = won?(myboard)
#puts hi

def full?(board)
  board.none? do |item|
    item == " " || item   == ""
  end
end

def draw?(board)
  if won?(board) == nil && full?(board)
    return true
  elsif won?(board) == nil && !full?(board)
    return false
  else full?(board) || !full?(board)
    #ridiculous but it looks like certain boards fail the won and thus the full method was never called and that fails a tests
    #weirdly this still says full was not called with that particular board they used for testing
    return false
  end
end

drawboard = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
incomplete_board = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
wonboard = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
puts draw?(incomplete_board) #=> false
puts draw?(drawboard) #true
puts draw?(wonboard) #false


def over?(board)
  if draw?(board) || won?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  #ex: if winningcombo is [2,4,6], board[winningcombo[0]] = board[2] = either X or O
  winningcombo = won?(board)
  if winningcombo == nil
    return nil
  else
    return board[winningcombo[0]]
  end
end


#----------------------
#----------------------
#----------------------
#CURRENT player
def turn_count(board)
  turns = 0

  board.each do | item |
    if item == "X" || item == "O"
      turns +=1
    end
  end

  return turns
end

def current_player(board)
  turns = turn_count(board)

  if (turns % 2 == 0)
    return "X"
  else
    return "O"
  end

end


#----------------------
#----------------------
#----------------------
# PLAY  stuff

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player: "X")
  board[index] = current_player
end
#not sure why it says the move? method doesn't accept an optional third argument
miboard = ["X ", " ", " "]
 move(miboard,2, "O")
 move(miboard,1)
 print miboard

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    puts "invalid move"
    turn(board)
  end

end
#note on the turn method above:
#if its an invalid move, it does  call itself again
#BUT, if it's a valid move, it only plays once. the method terminates
# Define your play method below
def play(board)

  loop do

    turn(board)

    boardnotfull = (board.include?(" ") || board.include?(""))
    #variable must be inside so that e4very loop re calculate the value of boardisfull
    # otherwie it's static
    #crucial

    if !boardnotfull
      break
    end

  end
end


#----------------------
#----------------------
#----------------------
