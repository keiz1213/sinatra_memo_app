# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'cgi/escape'
require 'pg'

db_connection = PG.connect(dbname: 'postgres')
db_connection.exec('CREATE TABLE IF NOT EXISTS mymemos (id serial, title text,content text)')

def find_memo(id, connection)
  memos = connection.exec('SELECT * FROM mymemos')
  memos.find { |m| m['id'] == id }
end

def post_memo(params, connection)
  title = params['title']
  content = params['content']
  connection.exec('INSERT INTO mymemos (title,content) values($1,$2)', [title, content])
end

def delete_memo(id, connection)
  connection.exec("DELETE from mymemos where id = #{id}")
end

def edit_memo(id, connection)
  title = params['title']
  content = params['content']
  connection.exec('UPDATE mymemos set title = $1,content =$2 where id = $3', [title, content, id])
end

get '/' do
  @title = 'My Memo'
  @memos = db_connection.exec('SELECT * FROM mymemos')
  erb :home
end

get '/memos/new' do
  @title = 'New Memo'
  erb :new
end

post '/memos/new' do
  post_memo(params, db_connection)
  redirect to('/')
end

get '/memos/:id' do |id|
  @id = id
  memo = find_memo(@id, db_connection)
  @memo_title = (memo['title'])
  @memo_content = (memo['content'])
  @title = @memo_title
  erb :memos
end

delete '/memos/:id' do |id|
  @id = id
  delete_memo(@id, db_connection)
  redirect to '/'
end

get '/memos/:id/edit' do |id|
  @id = id
  memo = find_memo(@id, db_connection)
  @memo_title = (memo['title'])
  @memo_content = (memo['content'])
  @title = @memo_title
  erb :edit
end

patch '/memos/:id' do |id|
  @id = id
  edit_memo(@id, db_connection)
  redirect to('/')
end
