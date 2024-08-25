require 'net/http'

namespace :auto_refresh do
  task :home, [:times] do |t, args|
    count = 0
    times = args[:times].to_i
    uri = URI.parse('https://tabarnak.onrender.com')

    while count < times do
      response = Net::HTTP.get_response(uri)
      count += 1
      puts "calling for time " + count.to_s + " of " + times.to_s + ": " + response.code

      time_to_sleep = rand(10*60..14*60)
      sleep (time_to_sleep)
    end
  end
end
