require 'sinatra'
require 'pg'
require 'bcrypt'
require 'dotenv/load'

def db_connect
  @db ||= PG.connect(
    dbname: 'bike_shop'
  )
end

get '/' do
  "DB connection success!"
end