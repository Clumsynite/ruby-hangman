# frozen_string_literal: true

require 'yaml'

# Save game as current state
class Save
  attr_accessor :secret_word, :guess_word_array, :dash, :turn

  def initialize(secret_word, guess_word_array, dash, turn)
    @secret_word = secret_word
    @guess_word_array = guess_word_array
    @dash = dash
    @turn = turn
  end

  def write_save
    File.open('save.yaml', 'w') unless File.exist? 'save.yaml'
    data = { secret_word: @secret_word, guess_word_array: @guess_word_array, dash: @dash, turn: @turn }
    File.open('save.yaml', 'w') { |file| file.write(data.to_yaml) }
  end
end
