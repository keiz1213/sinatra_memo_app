# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'cgi/escape'

def escape_params(params)
  params['title'] = CGI.escapeHTML(params['title'])
  params['content'] = CGI.escapeHTML(params['content'])
end

get '/' do
  @title = 'My Memo'
  File.open('db/memos.json') do |file|
    @memos = if file.size.zero?
               []
             else
               JSON.parse(file.read)
             end
  end

  erb :home
end

get '/memos/new' do
  @title = 'New Memo'
  erb :new
end

post '/memos/new' do
  escape_params(params)
  ary = []
  ids = []
  File.open('db/memos.json', 'r+') do |file|
    if file.size.zero?
      params['id'] = 1
      ary << params
      file.puts(JSON.generate(ary))
    else
      memos = JSON.parse(file.read)
      if memos == []
        params['id'] = 1
      else
        memos.each do |memo|
          ids << memo['id']
        end
        params['id'] = ids.max + 1
      end
      memos << params
      File.open('db/memos.json', 'w') do |f|
        f.puts(JSON.generate(memos))
      end
    end
  end
  redirect to('/')
end

get '/memos/:id' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memos.each do |memo|
    if memo['id'] == @id
      @memo_title = (memo['title']).to_s
      @memo_content = (memo['content']).to_s
    end
  end
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
  memos.each do |memo|
    if memo['id'] == @id
      @memo_title = (memo['title']).to_s
      @memo_content = (memo['content']).to_s
    end
  end
  @title = @memo_title
  erb :edit
end

patch '/memos/:id' do |id|
  @id = id.to_i
  memos = File.open('db/memos.json') { |file| JSON.parse(file.read) }
  memos.each do |memo|
    next unless memo['id'] == @id

    escape_params(params)
    memo['title'] = params['title']
    memo['content'] = params['content']
  end
  File.open('db/memos.json', 'w') { |file| file.puts(JSON.generate(memos)) }
  redirect to('/')
end
