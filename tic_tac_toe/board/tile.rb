class Board
    class Tile
        def initialize(position)
            @piece = Piece.new
            @position = position
        end

        def set(piece)
            return false if set?
            @piece = piece
        end

        def set?
            @piece.check(X.new) || @piece.check(O.new)
        end

        def to_string
            if set?
                @piece.to_string
            else
                @position
            end
        end

        def check(p)
            @piece.check(p)
        end
    end
end

