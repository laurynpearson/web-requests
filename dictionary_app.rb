require "http"

while true
puts "Enter a word. Enter 'q' to quit."
user_input = gets.chomp
  if user_input == "q"
    break
  else
    response = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=")

    p "The definition of #{user_input} is: #{response.parse[0]["text"]}."

    top_example = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/topExample?useCanonical=false&api_key=")

    p "The top example of #{user_input} is: #{top_example.parse["text"]}."

    pronounce = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/pronunciations?useCanonical=false&limit=50&api_key=")

    p "And the pronounciation of #{user_input} is: #{pronounce.parse[0]["raw"]}."
  end
end
