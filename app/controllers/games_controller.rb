require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @letters = params[:letters]
    # TODO: generate random grid of letters
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # puts @letters To check whether we have acces to @letters
    @word = params[:word] # Gives access to the user input that was named word
    @letters = params[:letters]
    letters_match = @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @letters.count(letter) }
    if letters_match
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      dictionary = JSON.parse(URI.open(url).read)
      if dictionary["found"]
        @result = "Well Done!"
      else
        @result = "Not an English word!"
      end
    else
      @result = "Word is not in the grid!"
    end
  end
end

# def score
#   # puts @letters To check whether we have acces to @letters
#   @word = params[:word] # Gives access to the user input that was named word
#   @letters = params[:letters]
#   url = "https://wagon-dictionary.herokuapp.com/#{@word}"
#   dictionary = JSON.parse(URI.open(url).read)
#   if dictionary["found"] == true
#     if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @letters.count(letter) }
#       @result = "Well Done!"
#     else
#       @result = "Word is not in the grid!"
#     end
#     return @result
#   else
#     @result = "not an english word"
#   end
#   return @result
# end
