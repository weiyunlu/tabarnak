require 'net/http'

namespace :auto_refresh do
  task :home do
    uri = URI.parse('https://tabarnak.onrender.com/home')
    response = Net::HTTP.get_response(uri)
  end
end
