require 'bundler/setup'
require 'json'
require 'net/http'
require 'sinatra'

SLACK_TOKEN="HSQHPuxOclUKL199AvX3GN5w"
GIPHY_KEY="dc6zaTOxFJmzC"
TRIGGER_WORD="#gif_me#"
IMAGE_STYLE="fixed_height"


post "/fat" do
	"fat"
end

get "/" do
	"pony"
end

post "/gif" do
	return 401 unless request["token"] == SLACK_TOKEN
	q = request["text"]
	return 200 unless q.start_with? TRIGGER_WORD
	q = URI::encode q[TRIGGER_WORD.size..-1]
	url = "http://api.giphy.com/v1/gifs/search?q=#{GIPHY_KEY}&limit=50"
	resp = Net::HTTP.get_response(URI.parse(url))
	buffer = resp.body
	result = JSON.parse(buffer)
	images = result["data"].map {|item| item["images"]}
	# filter out images > 2MB(?) because Slack
	images.select! {|image| image["original"]["size"].to_i < 1<<21}
	if images.empty?
		text = "your gif was too fat"
	else
		selected = images[rand(images.size)]
		text = "<" + selected[IMAGE_STYLE]["url"] + ">"
	end
	reply = {username: "davebot", text: text}
	return JSON.generate(reply)
end