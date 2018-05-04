class Piece
    def check(p)
        p.class == self.class
    end

    def to_string
        " "
    end
end

class X < Piece
    def to_string
        "X"
    end
end

class O < Piece
    def to_string
        "O"
    end
end

