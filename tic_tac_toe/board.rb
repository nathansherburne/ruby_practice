require_relative 'board/tile'
require_relative 'piece'

class Board
    @@position_map = { a: [0,0], b: [0,1], c: [0,2],
                       d: [1,0], e: [1,1], f: [1,2],
                       g: [2,0], h: [2,1], i: [2,2] }

    def initialize
        @board = [[Tile.new('a'), Tile.new('b'), Tile.new('c')],
                  [Tile.new('d'), Tile.new('e'), Tile.new('f')],
                  [Tile.new('g'), Tile.new('h'), Tile.new('i')]]
    end

    def set(position, piece)
        i, j = @@position_map[position.to_sym]
        return false if i.nil? || j.nil?
        @board[i][j].set(piece)
    end

    def x_win?
        check_win(X.new)
    end

    def o_win?
        check_win(O.new)
    end

    def cats_game?
        @board.all? { |row| row.all? { |tile| tile.set? } }
    end

    def to_string
        fill_n = 1
        win = find_win
        h_sep = '-'
        v_sep = '|'
        fill = ' '
        r1 = win == 'r1' ? h_sep : fill
        r2 = win == 'r2' ? h_sep : fill
        r3 = win == 'r3' ? h_sep : fill
        c1 = win == 'c1' ? v_sep : fill
        c2 = win == 'c2' ? v_sep : fill
        c3 = win == 'c3' ? v_sep : fill
        d1 = win == 'd1' ? '\\' : fill
        d2 = win == 'd2' ? '/' : fill
        str_arr = @board.map { |row| row.map { |tile| tile.to_string } }
        "
        #{d1}#{fill*(fill_n-1)}#{c1}#{fill*fill_n}#{v_sep}#{fill*fill_n}#{c2}#{fill*fill_n}#{v_sep}#{fill*fill_n}#{c3}#{fill*(fill_n-1)}#{d2} 
        #{r1*fill_n}#{str_arr[0][0]}#{r1*fill_n}#{v_sep}#{r1*fill_n}#{str_arr[0][1]}#{r1*fill_n}#{v_sep}#{r1*fill_n}#{str_arr[0][2]}#{r1*fill_n}   
        #{fill*fill_n}#{c1}#{fill*(fill_n-1)}#{d1}#{v_sep}#{fill*fill_n}#{c2}#{fill*fill_n}#{v_sep}#{d2}#{fill*(fill_n-1)}#{c3}#{fill*fill_n}
        #{h_sep*((fill_n * 2 + 1) * 3 + 2)} 
        #{fill*fill_n}#{c1}#{fill*fill_n}#{v_sep}#{d1}#{fill*(fill_n-1)}#{c2}#{fill*(fill_n-1)}#{d2}#{v_sep}#{fill*fill_n}#{c3}#{fill*fill_n} 
        #{r2*fill_n}#{str_arr[1][0]}#{r2*fill_n}#{v_sep}#{r2*fill_n}#{str_arr[1][1]}#{r2*fill_n}#{v_sep}#{r2*fill_n}#{str_arr[1][2]}#{r2*fill_n}   
        #{fill*fill_n}#{c1}#{fill*fill_n}#{v_sep}#{d2}#{fill*(fill_n-1)}#{c2}#{fill*(fill_n-1)}#{d1}#{v_sep}#{fill*fill_n}#{c3}#{fill*fill_n}
        #{h_sep*((fill_n * 2 + 1) * 3 + 2)} 
        #{fill*fill_n}#{c1}#{fill*(fill_n-1)}#{d2}#{v_sep}#{fill*fill_n}#{c2}#{fill*fill_n}#{v_sep}#{d1}#{fill*(fill_n-1)}#{c3}#{fill*fill_n} 
        #{r3*fill_n}#{str_arr[2][0]}#{r3*fill_n}#{v_sep}#{r3*fill_n}#{str_arr[2][1]}#{r3*fill_n}#{v_sep}#{r3*fill_n}#{str_arr[2][2]}#{r3*fill_n}   
        #{d2}#{fill*(fill_n-1)}#{c1}#{fill*fill_n}#{v_sep}#{fill*fill_n}#{c2}#{fill*fill_n}#{v_sep}#{fill*fill_n}#{c3}#{fill*(fill_n-1)}#{d1}
        "
    end

    private

    def check_win(p)
        row_i = @board.find_index { |row| row.all? { |tile| tile.check(p) } }
        return "r#{(row_i+1).to_s}" if row_i
        col_i = @board.transpose.find_index { |row| row.all? { |tile| tile.check(p) } }
        return "c#{(col_i+1).to_s}" if col_i
        d1 = @board.each_with_index.all? { |row, i| row[i].check(p) }
        return "d1" if d1
        d2 = @board.reverse.each_with_index.all? { |row, i| row[i].check(p) } 
        return "d2" if d2
    end

    def find_win
        x = check_win(X.new)
        o = check_win(O.new)
        return x if x
        return o if o
    end
end

