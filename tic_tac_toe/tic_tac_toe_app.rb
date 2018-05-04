require_relative 'board'
require_relative 'piece'

board = Board.new
o_turn = true
while true
    puts board.to_string

    if o_turn
        puts "O's turn"
        piece = O.new
    else
        puts "X's turn"
        piece = X.new
    end

    print "Pick a tile to place your piece on (a-i): "
    position = gets.chomp

    if board.set(position, piece)
        if board.x_win? 
            puts "X wins!!"
            puts board.to_string
            break
        elsif board.o_win? 
            puts "O wins!!"
            puts board.to_string
            break
        elsif board.cats_game?
            puts "Cats game!!"
            puts board.to_string
            break
        else
            o_turn = !o_turn
        end
    else
        puts "Warning: invalid tile!"
    end
end

