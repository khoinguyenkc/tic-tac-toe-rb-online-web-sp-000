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

def move(board, index, current_player )
  board[index] = current_player
end
#the test say your function SHOULD not allow default third
#which means now it forces you to enter the current player
#not sure why it says the move? method doesn't allow for a default third argument
miboard = ["X ", " ", " "]
 print miboard

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  current_player = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)


  else
    #put it in a loop
    inputnowvalid = false

    until inputnowvalid == true
      puts "Please enter 1-9:"
      input = gets.strip
      getthenewmove = input_to_index(input)

      inputnowvalid = valid_move?(board, getthenewmove)
      #if vaid, input nowvalid becomes true. that will stop the loop.
      #othrewise, this keeps going forever
    end #end of loop

    #if loop is finished, take new move and send it in
    move(board, getthenewmove, current_player)
    display_board(board)
  end #end of if & else

end
#note on the turn method above:
#if its an invalid move, it does  call itself again
#BUT, if it's a valid move, it only plays once. the method terminates
# Define your play method below
def play(board)
  #A tic tac toe game must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game
  until over?(board) do
    turn(board)

  end

  if over?(board)
    if won?(board)

      puts "Congratulations #{winner(board)}!"
    else #aka a draw
      puts "Cat's Game!"
    end
  end
  #boardnotfull = (board.include?(" ") || board.include?(""))
  #variable must be inside so that e4very loop re calculate the value of boardisfull
  # otherwie it's static
  #crucial
  #if !boardnotfull
  #  break
  #end

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
  if full?(board) && won?(board) == nil
    return true
  else
    return false
  end
end
#super interesting: simplifying the structure gets rid of the error

drawboard = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
incomplete_board = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
wonboard = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
puts draw?(incomplete_board) #=> false
puts draw?(drawboard) #true
puts draw?(wonboard) #false


def over?(board)
  if draw?(board) || won?(board)
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
