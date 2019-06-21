# Build a terminal dictionary app

# Create a new ruby file called dictionary_app.rb

# The program should ask the user to enter a word, then use the wordnik API to show the word’s definition: https://developer.wordnik.com/docs#!/word/getDefinitions

# Once that works, have it also display the top example and pronunciation (browse through the documentation to the top example and pronunciation).

# Bonus: Write your program in a loop such that the user can keep entering new words without having to restart the program. Give them the option of entering q to quit.

# Bonus: Search for the audio section in the documentation. Use wordnik’s audio api to get the first fileUrl to open in the browser (you’ll need to google this!) and pronounce the name of the word.




require "http"
require "launchy"

while true
puts "Enter a word. Enter 'q' to quit."
user_input = gets.chomp
  if user_input == "q"
    break
  else
    response = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=")

    p "The definition of #{user_input} is: #{response.parse[1]["text"]}."
    top_example = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/topExample?useCanonical=false&api_key=")

    p "The top example of #{user_input} is: #{top_example.parse["text"]}."

    pronounce = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/pronunciations?useCanonical=false&limit=50&api_key=")

    p "And the pronounciation of #{user_input} is: #{pronounce.parse[0]["raw"]}."

    audio = HTTP.get("https://api.wordnik.com/v4/word.json/#{user_input}/audio?useCanonical=false&limit=50&api_key=")

    p "The audio pronounciation of #{user_input} will open in your browser." 
    Launchy.open(audio.parse[0]["fileUrl"])
  end
end


