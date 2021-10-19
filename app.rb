require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end


get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end 

post '/visit' do
	@hairdresser = params[:hairdresser]
	@username = params[:username]
	@phone     = params[:phone]
	@datetime = params[:datetime]

	@title = 'Thank you!'
	@message = "Dear #{@username}, we'll be waiting for you at #{@datetime},  #{@hairdresser}"

	f = File.open './public/users.txt', 'a'
	f.write "Hairdresser: #{@hairdresser}, user: #{@username}, Phone: #{@phone}, Date and time: #{@datetime}"
	f.close

	erb :message
end

post '/contacts' do
	@emailuser = params[:emailuser]
	@contacts_message = params[:contacts_message]

	@title = 'Благодарим за Ваш отзыв'

	f = File.open './public/contacts.txt', 'a'
	f.write "User: #{@emailuser}, text: #{@contacts_message}"

	erb :message
end

get '/admin' do
	erb :admin
end

post '/admin' do
	@login = params[:aaa]
	@password = params[:bbb] 

	if @login == 'admin' && @password == 'secret'
		send_file './public/users.txt'
	else
		@message = 'Access denied!'
   		erb :admin
	end
end
