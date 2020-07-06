# frozen_string_literal: true

# Hangman class with the game logic
class Hangman
  attr_accessor :secret_word, :guess, :guess_word
  def initialize
    @secret_word = secret_word
    @guess = guess
    @guess_word_array = []
    @guess_word = guess_word
  end

  def create_secret_word
    word_list = File.read '5desk.txt'
    words_array = word_list.split(' ')
    word_sample = words_array.sample
    word_sample = words_array.sample until word_sample.length.between?(5, 12)
    @secret_word = word_sample.downcase
  end

  def create_secret_word_as_dash
    @dash = Array.new(@secret_word.length, '-')
  end

  def display_secret_word_as_dash
    puts @dash.join(' ')
  end

  def guess_secret_word
    puts "\nYou have 10 turns to guess the Secret word set by me"
    10.times do |time|
      print "\n#{10 - time} Guesses left -> "
      display_secret_word_as_dash
      ask_for_letter
      display_secret_word_as_dash
      check_win_state(time)
    end
  end

  def ask_for_letter
    @guessed = false
    puts "Letters guessed: #{@guess_word_array.join(' ')}"
    puts 'Enter a character to guess the word'
    until @guessed
      guess = gets.chomp!.downcase.strip
      check_guess_letter(guess)
    end
  end

  def check_guess_letter(guess)
    if guess.match(/[a-z]/) && guess.length == 1 && !already_guessed?(guess)
      @guessed = true
      @guess_word_array.push(guess)
      validate_guess_letter(guess)
    elsif already_guessed?(guess)
      puts "You have already guess this character\nTry another one"
    elsif guess.match(/[^a-z]/)
      puts 'Please enter AN alphabet'
    end
  end

  def validate_guess_letter(letter)
    if @secret_word.include?(letter)
      same_index = (0...(@secret_word.length)).find_all { |i| @secret_word[i, 1] == letter }.inspect
      replace_same_index_dash(same_index, letter)
    else
      puts "\nThis letters is not in my word\nTry another letter"
    end
  end

  def already_guessed?(letter)
    @guess_word_array.include?(letter)
  end

  def replace_same_index_dash(same_index, letter)
    (0...@dash.length).each do |time|
      @dash[time] = letter if same_index.include?(time.to_s)
    end
  end

  def dash_filled?
    @dash.count('-').zero?
  end

  def check_win_state(time)
    if dash_filled? && time <= 9
      abort("\nYou won\nThe word was #{@secret_word}")
    elsif !dash_filled? && time == 9
      abort("\nOh no! You lost\nThe word was #{@secret_word}")
    end
  end
end

# Game class to start the game
class Game
  def initialize
    @hangman = Hangman.new
  end

  def heading
    puts "\nWelcome to Hangman by Clumsyknight"
    puts "\nIf you know the rules, skip this part"
    rules
  end

  def rules
    puts "\nSo, the rules here are as follows"
    puts <<-HEREDOC
       1. I have a word with me, which you'll have to guess in 10 turns
       2. The word to guess is represented by a row of dashes, representing each letter of the word.
       3. If you guess a letter which occurs in the word, I'll write it in all its correct positions.
       4. Now, normally there's a stick figure which is drawn every time you make a wrong guess
          But, I can't draw something like that.
          So, If you make a wrong guess it'll cost you nothing, Woohoo!. Except for the fact that you wasted a turn.
       5. There'll be a list of letters you guessed shown to you everytime you guess
       6. You can't guess a letter which you have guessed earlier
       7. Boring part ends. Now you can play the game.
    HEREDOC
  end

  def start
    heading
    @hangman.create_secret_word
    @hangman.create_secret_word_as_dash
    @hangman.guess_secret_word
  end
end

game = Game.new
game.start
