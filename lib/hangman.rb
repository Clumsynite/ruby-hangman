# frozen_string_literal: true

# Hangman class with the game logic
class Hangman
  attr_accessor :secret_word, :guess
  def initialize
    @secret_word = secret_word
    @guess = guess
    @guess_word_array = []
    @load = Load.new
    @turn = 0
  end

  def create_secret_word
    word_list = File.read '5desk.txt'
    words_array = word_list.split(' ')
    word_sample = words_array.sample
    word_sample = words_array.sample until word_sample.length.between?(5, 12)
    @secret_word = word_sample.downcase
    @dash = Array.new(@secret_word.length, '-')
  end

  def display_secret_word_as_dash
    puts @dash.join(' ')
  end

  def guess_secret_word
    until @turn >= 10
      print "\n#{10 - @turn} Guesses left -> "
      display_secret_word_as_dash
      ask_for_letter
      display_secret_word_as_dash
      check_win_state(@turn)
      @turn += 1
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
    if guess == 'save' || guess == 'load'
      save_or_load(guess)
    elsif guess.match(/^[a-z]$/) && !already_guessed?(guess)
      push_to_array(guess)
    elsif already_guessed?(guess)
      puts "You have already guess this character\nTry another one"
    else
      puts 'Please enter AN alphabet'
    end
  end

  def save_or_load(guess)
    save_game if guess == 'save'
    load_game if guess == 'load'
  end

  def save_game
    @save = Save.new(@secret_word, @guess_word_array, @dash, @turn)
    @save.write_save
    puts 'Game saved Successfully'
  end

  def load_game
    lo = @load.load_file
    @secret_word = lo[:secret_word]
    @guess_word_array = lo[:guess_word_array]
    @dash = lo[:dash]
    @turn = lo[:turn]
    puts "\nGame loaded to your last saved state\n#{10 - lo[:turn]} Guesses left -> #{lo[:dash].join(' ')}"
    puts "Letters guessed: #{lo[:guess_word_array].join(' ')}"
  end

  def push_to_array(guess)
    @guessed = true
    @guess_word_array.push(guess)
    validate_guess_letter(guess)
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
