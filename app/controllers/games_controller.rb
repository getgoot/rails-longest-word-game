require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z').sample(10)
  end

  def score
    user_input = params[:suggestion].upcase
    letters_in_grid = params[:letters].split('')
    valid_word_in_grid = word_can_be_built?(user_input, letters_in_grid)
    valid_word_english = word_is_english?(user_input)

    if valid_word_in_grid && valid_word_english
      @result = 'Congratulations! The word is valid.'
    elsif !valid_word_in_grid
      @result = 'The word can\'t be built out of the original grid.'
    elsif !valid_word_english
      @result = 'The word is not a valid English word.'
    else
      @result = 'Invalid letters: The word contains letters not present in the original grid.'
    end

    # Redirect to the result page with the result message
    render 'result'
  end

  private

  def word_can_be_built?(word, grid)
    # Check if the word can be built using letters from the grid
    word.chars.all? { |letter| grid.include?(letter) && grid.delete_at(grid.index(letter)) }
  end

  def word_is_english?(word)
    # Check if the word is a valid English word using the API
    api_url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = JSON.parse(URI.open(api_url).read)
    response['found']
  end
end
