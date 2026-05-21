require 'sinatra'
require 'pg'
require 'bcrypt'
require 'dotenv/load'

get '/' do
  erb :index
end