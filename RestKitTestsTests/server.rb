# RestKit Sinatra Testing Server
# Place at Tests/server.rb and run with `ruby Tests/Server.rb` before executing the test suite within Xcode

require 'rubygems'
require 'sinatra'
require 'json'

configure do
  set :logging, true
  set :dump_errors, true
  set :public_folder, Proc.new { File.expand_path(File.join(root, 'Fixtures')) }
end

def render_fixture(filename)
  send_file File.join(settings.public_folder, filename)
end

# send_file doesn't seem to accept the :status option. :-(
# def render_error(filename)
#   send_file File.join(settings.public_folder, filename), 
#     :status => 422,
#     :type => 'application/json'
# end

# Creates a route that will match /categories/<category ID>
get '/categories/:id' do
  render_fixture('category.json')
end

# Creates a route that will match /categories
get '/categories' do
  render_fixture('categories.json')
end

get '/items/:id' do
  render_fixture('item.json')
end

get '/items' do
  render_fixture('items.json')
end

post '/items' do
  if params[:name]
    render_fixture('new_item.json')
  else
    status 422
    content_type 'application/json'
    "{\"errors\":[\"Name required\", \"Price required\"]}"
    # render_error('item_error.json')
  end
end

# Return a 503 response to test error conditions
get '/offline' do
  status 503
end

# Simulate a JSON error
get '/error' do
  status 400
  content_type 'application/json'
  "{f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;errorf36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;: f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;An error occurred!!f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;}"
end