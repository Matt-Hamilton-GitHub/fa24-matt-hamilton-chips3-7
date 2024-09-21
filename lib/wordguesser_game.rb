class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @num_guesses = 7
    @last_char = ''
  end

  # def guess(c)
  #   ch = c.downcase
  #   return false unless ch.match?(/[a-z]/)
  #   ch = c.downcase
  #   if (@word.include?(ch) && @num_guesses != 0 && !@guesses.include?(ch) && ch.match?(/[a-z]/) && (ch != @last_char) || @last_char == '')
  #     @guesses += ch
  #     @last_char = ch
  #     return true
  #   elsif (ch.match?(/[a-z]/) && !@wrong_guesses.include?(ch) && ch != @last_char)
  #     @wrong_guesses += ch
  #     @num_guesses -= 1
  #     @last_char = ch
  #     return true
  #   else 
  #    return false
  #   end
  # end

  def guess(c)
    ch = c.downcase
    raise ArgumentError, 'Enter a letter' if ch == '' || !ch.match?(/[a-z]/)
    return false unless ch.match?(/[a-z]/) 

    if @guesses.include?(ch) || @wrong_guesses.include?(ch)
      return false 
    end

    if @word.include?(ch)
      @guesses += ch
      @last_char = ch

      return true 
    else
      @wrong_guesses += ch
      @num_guesses -= 1
      @last_char = ch

      return true 
    end
  end

  def word_with_guesses
    st = @word.chars.map { |ch| @guesses.include?(ch) ? ch : '-' }.join
    puts st
    return st
  end

  def check_win_or_lose
    if @num_guesses <= 0
      :lose
    elsif @word.chars.all? { |ch| @guesses.include?(ch) }
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
