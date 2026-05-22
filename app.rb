require 'sinatra'
require 'pg'
require 'bcrypt'
require 'dotenv/load' unless ENV['RAILWAY_ENVIRONMENT']

enable :sessions

set :bind, "0.0.0.0"
set :port, ENV.fetch("PORT", 8080)

set :protection, host_authorization: false
set :environment, ENV.fetch("RACK_ENV", "production")

# connect to database
def db_connect
  @db ||= if ENV['DATABASE_URL']
    PG.connect(ENV['DATABASE_URL'])   # Railway / production
  else
    PG.connect(dbname: ENV['DATABASE_NAME'])  # local dev
  end
end

helpers do

  # checks if a user is logged in
  def current_user
    return nil unless session[:user_id]

    result = db_connect.exec_params(
      "SELECT * FROM users WHERE id = $1",
      [session[:user_id]]
    )

    result.first
  end

  # if a user that isn't logged in tries to access a cart/order/etc., require login first
  def require_login
    redirect '/login' unless current_user
  end

  # checks if cart for user exists or creates a new cart
  def current_cart
  result = db_connect.exec_params(
    "SELECT * FROM carts WHERE user_id = $1",
    [current_user['id']]
  )

    if result.ntuples > 0
      result.first
    else
      new_cart = db_connect.exec_params(
        "INSERT INTO carts (user_id)
        VALUES ($1)
        RETURNING *",
        [current_user['id']]
      )

      new_cart.first
    end
  end

end

get '/' do
  erb :index
end

# view catalog of bikes
get '/bikes' do
  @bikes = db_connect.exec("SELECT * FROM bicycles ORDER BY name")
  erb :bikes
end

# view individual bikes
get '/bikes/:id' do
  result = db_connect.exec_params(
    "SELECT * FROM bicycles WHERE id = $1",
    [params[:id]]
  )

  halt 404 if result.ntuples == 0

  @bike = result.first

  erb :bike
end

# registration
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

# login
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

# logout
get '/logout' do
  session.clear
  redirect '/'
end

# view cart
get '/cart' do
  require_login

  cart = current_cart

  @items = db_connect.exec_params(
    "
    SELECT
      cart_items.id,
      cart_items.quantity,
      bicycles.name,
      bicycles.price,
      bicycles.id AS bicycle_id
    FROM cart_items
    JOIN bicycles
      ON bicycles.id = cart_items.bicycle_id
    WHERE cart_items.cart_id = $1
    ",
    [cart['id']]
  )
  erb :cart

end

# add items to cart
post '/cart/add/:bike_id' do
  require_login

  bike_id = params[:bike_id]
  cart = current_cart
  existing_item = db_connect.exec_params(
    "SELECT * FROM cart_items
     WHERE cart_id = $1
     AND bicycle_id = $2",
    [
      cart['id'],
      bike_id
    ]
  )

  if existing_item.ntuples > 0
    db_connect.exec_params(
      "UPDATE cart_items
       SET quantity = quantity + 1
       WHERE id = $1",
      [
        existing_item.first['id']
      ]
    )
  else
    db_connect.exec_params(
      "INSERT INTO cart_items
       (cart_id, bicycle_id, quantity)
       VALUES ($1, $2, 1)",
      [
        cart['id'],
        bike_id
      ]
    )
  end
  redirect '/cart'

end

# remove items from cart
post '/cart/remove/:item_id' do
  require_login

  db_connect.exec_params(
    "DELETE FROM cart_items
     WHERE id = $1",
    [params[:item_id]]
  )
  redirect '/cart'

end