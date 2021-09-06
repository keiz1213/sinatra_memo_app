# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'cgi/escape'

get '/' do
  @title = 'My Memo'
  begin
    @memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  rescue StandardError
    File.open('db/memos.json', 'w') do |file|
      file.puts('[]')
    end
    @memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  end
  erb :home
end

get '/memos/new' do
  @title = 'New Memo'
  erb :new
end

post '/memos/new' do
  File.open('db/memos.json', 'r+') do |file|
    memos = JSON.parse(file.read)
    params['id'] = if memos == []
                     1
                   else
                     memos.map { |memo| memo['id'] }.max + 1
                   end
    memos << params
    File.open('db/memos.json', 'w') do |f|
      f.puts(JSON.generate(memos))
    end
  end
  redirect to('/')
end

get '/memos/:id' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memo = memos.filter { |m| m['id'] == @id }
  @memo_title = (memo[0]['title'])
  @memo_content = (memo[0]['content'])
  @title = @memo_title
  erb :memos
end

delete '/memos/:id' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memos.each_with_index do |memo, index|
    memos.delete_at(index) if memo['id'] == @id
  end
  File.open('db/memos.json', 'w') { |file| file.puts(JSON.generate(memos)) }
  @title = @memo_title
  redirect to '/'
end

get '/memos/:id/edit' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memo = memos.filter { |m| m['id'] == @id }
  @memo_title = (memo[0]['title'])
  @memo_content = (memo[0]['content'])
  @title = @memo_title
  erb :edit
end

patch '/memos/:id' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memo = memos.filter { |m| m['id'] == @id }
  memo[0]['title'] = params['title']
  memo[0]['content'] = params['content']
  File.open('db/memos.json', 'w') { |file| file.puts(JSON.generate(memos)) }
  redirect to('/')
end
