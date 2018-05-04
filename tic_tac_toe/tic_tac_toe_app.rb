require_relative 'board'
require_relative 'piece'

def quit_game
    puts "Thanks for playing! Goodbye!"
    exit
end


another_game_str = nil
while true
    board = Board.new
    o_turn = true
    puts "Ready to play a#{another_game_str} game of Tic Tac Toe? Press 'q' to quit. Press Enter to continue: "
    another_game_str ||= "nother"
    quit_game if gets.chomp == 'q'

    while true
        system "cls" or system 'clear'
        puts board.to_string
        if o_turn
            piece_str = 'O'
            puts "Player 1's turn (#{piece_str})"
            piece = O.new
        else
            piece_str = 'X'
            puts "Player 2's turn (#{piece_str})"
            piece = X.new
        end

        print "Pick a tile to place your #{piece_str}-piece on (a-i): "
        position = gets.chomp
        quit_game if position == 'q'

        if board.set(position, piece)
            if board.game_over?
                system "cls" or system 'clear'
                if board.x_win? 
                    puts "Player 2 wins!!"
                elsif board.o_win? 
                    puts "Player 1 wins!!"
                elsif board.cats_game?
                    puts "Cats game!!"
                end
                puts board.to_string
                break
            end
            o_turn = !o_turn
        else
            puts "Warning: invalid tile!"
        end
    end
end

