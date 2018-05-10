require_relative 'hangman/hangman'

def invalid_guess(letter)
  "Warning: '#{letter}' is an invalid guess. Try again...\n"
end

h = Hangman.new

system "cls" or system 'clear'
puts h.display
puts error if invalid_guess
print "Please guess a letter: "

until h.game_over?
  letter = gets.chomp
  system "cls" or system 'clear'
  puts h.display
  if !(h.guess(letter))
    puts 
  end
  print "Please guess a letter: "
end
system "cls" or system 'clear'
puts h.lost? ? "You lost!!" : "You won!!"
puts h.display
