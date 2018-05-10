class String
  def indexes(c)
    i = -1
    all = []
    while i = self.index(c,i+1)
      all << i
    end
    all
  end
end
