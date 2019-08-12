require 'sinatra'
require './special_lexicon.rb'

set :haml, :format => :html5

configure do
  set :lexicon, SpecialLexicon.new
end

get '/' do
  haml :index
end

get '/anagrams/:word' do
  list = settings.lexicon.get_anagrams(params[:word])
  haml :output, :locals => {:list => list}
end

get '/prefixed/:pre' do
  list = settings.lexicon.get_prefixed_words(params[:pre])
  haml :output, :locals => {:list => list}
end

get '/word_ladder/:start/:end' do
  list = settings.lexicon.get_word_ladder(params[:start], params[:end])
  haml :output, :locals => {:list => list}
end
