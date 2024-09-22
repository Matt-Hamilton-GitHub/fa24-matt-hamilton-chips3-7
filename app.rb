require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || WordGuesserGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
    erb :new
  end
  
  get '/new' do
    redirect '/create'
  end

  post '/new' do
    redirect '/create'
  end

  get '/win' do
    if @game.win == true
      erb :win
    else
      redirect '/show'
    end
  end

  get '/lose' do
    if @game.lose == true
      erb :lose
    else
      redirect '/show'
    end
  end

  get '/show' do
    erb :show
  end

  get '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || WordGuesserGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = WordGuesserGame.new(word)

    redirect '/show'
  end
  
  # Use existing methods in WordGuesserGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###


    if letter.nil? || letter.empty? || !letter.match?(/[A-Za-z]/)
      flash[:message] = "Invalid guess."
    else
      result = @game.guess(letter)
  
      if !result
        flash[:message] = "You have already used that letter."
      elsif !letter.match?(/[A-Za-z]/)
        flash[:message] = "Invalid guess."
      end
    end

    @game.check_win_or_lose
    if @game.lose == true
      redirect '/lose'
    elsif @game.win == true
      redirect '/win'
    else
      redirect '/show'
    end
  end
  
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in WordGuesserGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.

  
 
  
end
