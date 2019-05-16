require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ("a".."z").to_a
    @letters = @alphabet.sample(10)
  end

  def score
    @word = params[:word].chars
    @letters = params[:letters].split(' ')

    if checkLetters(@word, @letters) == true && checkEnglish(@word) == true
      @answer = "Congratulations #{@word} is a valid English word"
    elsif checkLetters(@word, @letters) == true && checkEnglish(@word) == false
      @answer =  "Sorry but #{@word} doesn't seem to be a valid English word"
    else checkLetters(@word, @letters) == false && checkEnglish(@word) == true
      @answer =  "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end


  def checkLetters(word,letters)
    word.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def checkEnglish(word)
    word = word.join('')
    url = "https://wagon-dictionary.herokuapp.com/#{word}.json"
    check_serialized = open(url).read
    check = JSON.parse(check_serialized)
    check["found"]
  end
end
