[woeid|_rest] = System.argv
temp = CurrentWeather.YahooFetcher.fetch(woeid)
IO.puts "The current weather for woeid #{woeid} is #{temp} degrees fahrenheit."
