require 'net/http'
require 'sinatra'

get '/:name' do |name|
   resp = Net::HTTP.get_response(URI.parse(ENV['NEO4J_URL'] + "/dsr/words/#{name}"))
   resp.body
end
