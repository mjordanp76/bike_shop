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

helpers do
  def current_user
    return nil unless session[:user_id]

    result = db_connect.exec_params(
      "SELECT * FROM users WHERE id = $1",
      [session[:user_id]]
    )

    result.first
  end

end

helpers do

  def require_login
    redirect '/login' unless current_user
  end
  
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

  db_connect.exec_params(
    "INSERT INTO users (email, password_hash)
     VALUES ($1, $2)",
    [
      params[:email],
      password_hash
    ]
  )

  redirect '/'
end

get '/login' do
  erb :login
end

post '/login' do

  result = db_connect.exec_params(
    "SELECT * FROM users WHERE email = $1",
    [params[:email]]
  )

  if result.ntuples == 0
    return "Invalid email or password"
  end

  user = result.first

  if BCrypt::Password.new(user['password_hash']) == params[:password]
    session[:user_id] = user['id']
    redirect '/'

  else
    "Invalid email or password"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end