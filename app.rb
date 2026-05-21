require 'sinatra'
require 'pg'
require 'bcrypt'
require 'dotenv/load'

def db_connect
  @db ||= PG.connect(
    dbname: ENV['DATABASE_NAME']
  )
end

get '/' do
  "DB connection success!"
  result = db_connect.exec("SELECT * FROM bicycles")
  result.to_a.to_s
end