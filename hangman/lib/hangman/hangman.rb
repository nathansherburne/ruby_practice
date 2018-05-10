require_relative '../modify/string'
require_relative '../modify/enumerable'

class Hangman
  def initialize
    @secret_word = get_random_word 
    @current_display = '_' * @secret_word.length
    @incorrect_remaining = 6
    @valid_guesses = ('a'..'z').to_a
    @previous_guesses = []
  end

  def display
    @current_display = @secret_word if game_over?
    <<~RUBY
    #{@current_display.split('').join(' ')}
      
    Valid guesses: #{@valid_guesses.join(' ')}
    Previous guesses: #{@previous_guesses.join(' ')}
    Incorrect guesses remaining: #{@incorrect_remaining}

    RUBY
  end

  def guess(c)
    if valid_guess?(c)
      indexes = @secret_word.indexes(c)
      indexes.length > 0 ? correct_guess(c, indexes) : incorrect_guess
      @previous_guesses << c
      @valid_guesses.delete(c)
    else
      return false
    end
  end

  def game_over?
    lost? || won?
  end

  def lost?
    @incorrect_remaining == 0
  end

  def won?
    @current_display.count('_') == 0
  end

  private

  def valid_guess?(c)
    @valid_guesses.include?(c)
  end

  def incorrect_guess
    @incorrect_remaining -= 1
  end

  def correct_guess(c, indexes)
    indexes.each { |i| @current_display[i] = c }
  end

  def get_random_word
    words = File.open("../res/5desk.txt")
    words.random_line
  end
end
