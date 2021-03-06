require 'sinatra'
require './special_lexicon.rb'

set :haml, :format => :html5

configure do
  set :lexicon, SpecialLexicon.new
end

get '/' do
  haml :index
end

get '/betteranagrams/:word' do
  list = settings.lexicon.get_anagrams(params[:word])
  return list.to_json
end


get '/betterprefixes/:pre' do
  list = settings.lexicon.get_prefixed_words(params[:pre])
  return list.to_json
end


get '/betterLadder/:start/:end' do
  list = settings.lexicon.get_word_ladder(params[:start], params[:end])
  return list.to_json
end
