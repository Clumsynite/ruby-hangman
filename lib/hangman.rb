# frozen_string_literal: true

puts 'Welcome to Hangman by Clumsyknight'

def secret_word
  word_list = File.read '5desk.txt'
  words_array = word_list.split(' ')
  word_sample = words_array.sample
  word_sample = words_array.sample until word_sample.length.between?(5, 12)
  word_sample
end

puts secret_word
