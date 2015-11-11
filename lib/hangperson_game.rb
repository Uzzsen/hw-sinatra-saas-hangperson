class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
 def guess(letter)
    
    raise ArgumentError if letter.nil? || letter=~/[^\w]/ || letter.empty?
    
    return @guesses << letter if @word.include?(letter) && @guesses.empty?
    
    if @word.downcase.include?(letter.downcase) && @guesses.downcase.include?(letter.downcase) then
      return false
    elsif @word.include?(letter) && !@guesses.include?(letter) then
      @guesses << letter  
    elsif !@wrong_guesses.downcase.include?(letter.downcase) then
      @wrong_guesses << letter
    else
      false
    end  
    
 end
  
 def word_with_guesses
   @word.chars.map { |wl|
   @guesses.chars.any? { |gl| wl == gl} ? wl : "-"
    }.join
 end

 def check_win_or_lose
   if word_with_guesses == @word
     :win
   elsif @wrong_guesses.length >=7
     :lose
   elsif word_with_guesses != @word && @wrong_guesses.length <7
     :play
   end   
 end  
 
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
