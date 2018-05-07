class Piece
    def check(p)
        p.class == self.class
    end

    def to_s
        " "
    end
end

class X < Piece
    def to_s
        "X"
    end
end

class O < Piece
    def to_s
        "O"
    end
end

