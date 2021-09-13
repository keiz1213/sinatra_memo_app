# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'cgi/escape'
require 'pg'

CONNECTION = PG.connect(dbname: 'postgres')
CONNECTION.exec('CREATE TABLE IF NOT EXISTS mymemos (id serial, title text,content text)')

def find_memo(id)
  memos = CONNECTION.exec('SELECT * FROM mymemos')
  memos.find { |m| m['id'] == id }
end

def post_memo(params)
  title = params['title']
  content = params['content']
  CONNECTION.exec('INSERT INTO mymemos (title,content) values($1,$2)', [title, content])
end

def delete_memo(id)
  CONNECTION.exec("DELETE from mymemos where id = #{id}")
end

def edit_memo(id)
  title = params['title']
  content = params['content']
  CONNECTION.exec('UPDATE mymemos set title = $1,content =$2 where id = $3', [title, content, id])
end

get '/' do
  @title = 'My Memo'
  @memos = CONNECTION.exec('SELECT * FROM mymemos')
  erb :home
end

get '/memos/new' do
  @title = 'New Memo'
  erb :new
end

post '/memos/new' do
  post_memo(params)
  redirect to('/')
end

get '/memos/:id' do |id|
  @id = id
  memo = find_memo(@id)
  @memo_title = (memo['title'])
  @memo_content = (memo['content'])
  @title = @memo_title
  erb :memos
end

delete '/memos/:id' do |id|
  @id = id
  delete_memo(@id)
  redirect to '/'
end

get '/memos/:id/edit' do |id|
  @id = id
  memo = find_memo(@id)
  @memo_title = (memo['title'])
  @memo_content = (memo['content'])
  @title = @memo_title
  erb :edit
end

patch '/memos/:id' do |id|
  @id = id
  edit_memo(@id)
  redirect to('/')
end
