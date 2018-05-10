module Enumerable
  def random_line
    selected = nil
    each_with_index { |line, lineno| selected = line if rand < 1.0/lineno }
    return selected.chomp if selected
  end
end

