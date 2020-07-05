# frozen_string_literal: true

puts 'Welcome to Hangman by Clumsyknight'

word_list = File.read '5desk.txt'
words_array = word_list.split(' ')
puts words_array.sample
