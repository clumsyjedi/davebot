#ruby

#Based on gifbot by schuyler


require 'bundler/setup'
require 'json'
require 'net/http'
require 'sinatra'

SLACK_TOKEN="xoxb-3332122042-kmzKrC1qkyyZ2LwjIL1j5eK3"
GIPHY_KEY="dc6zaTOxFJmzC"
TRIGGER_WORD="#gif_me#"
IMAGE_STYLE="fixed_height"


post "/gif" do
	"yay"
end

get "/" do
	"boo"
end

post "/" do
	"fat"
end