# frozen_string_literal: true

require_relative './hangman.rb'
require_relative './save.rb'
require_relative './load.rb'

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

  def guess_info
    puts "\nYou have 10 turns to guess the Secret word set by me"
    puts "\nSpecial Keys: 'save' to save the game at any point"
    puts "              'load' to load the game from its previous save state"
  end

  def start
    heading
    guess_info
    @hangman.create_secret_word
    @hangman.guess_secret_word
  end
end

game = Game.new
game.start
