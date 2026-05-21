require 'sinatra'
require 'pg'
require 'bcrypt'
require 'dotenv/load'

enable :sessions

def db_connect
  @db ||= PG.connect(
    dbname: ENV['DATABASE_NAME']
  )
end

get '/' do
  erb :index
end

get '/bikes' do
  @bikes = db_connect.exec("SELECT * FROM bicycles ORDER BY name")
  erb :bikes
end

get '/bikes/:id' do
  result = db_connect.exec_params(
    "SELECT * FROM bicycles WHERE id = $1",
    [params[:id]]
  )

  halt 404 if result.ntuples == 0

  @bike = result.first

  erb :bike
end

get '/register' do
  erb :register
end

post '/register' do

  password_hash =
    BCrypt::Password.create(params[:password])

  db.exec_params(
    "INSERT INTO users (email, password_hash)
     VALUES ($1, $2)",
    [
      params[:email],
      password_hash
    ]
  )

  redirect '/'
end