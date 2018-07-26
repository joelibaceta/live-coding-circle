require "facebook/messenger"
include Facebook::Messenger
require 'net/http'
require 'uri'
require 'json'

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
    sender = message.sender['id']

    Message.create({
        author: sender,
        body: message.text
    })

    
    filtered_messages = Message.where("author == ?", sender).map{|msg| "#{get_name_from_id(msg.author)}: #{msg.body}"}
    filtered_reponses = Reponse.where("sender_id != ?", sender).map{|msg| "#{get_name_from_id(msg.sender_id)}: #{msg.body}"}

    puts "FILTERED MESSAGES: " + filtered_messages.inspect
    puts "FILTERED REPONSES: " + filtered_reponses.inspect

    messages_to_send = filtered_messages 

    
    messages_to_send.each do |msg|
        message.reply(text: msg)
    end
    
end

def get_name_from_id(id)
    uri = URI.parse("https://graph.facebook.com/v3.0/#{id}?access_token=EAAGJcZArwqG0BADe06loLaDDmmZB2t1gLjOaHiqFUZCge4CxPFRQJUQB3vfV2879drxedDh0aiICPxWo5JLfmReiCumSteiNRV8rlZACaKje5fpUDJsWwjZCZCatJCw3D4znVGJYF9ZAuySFhPrxrnLqKHZB1xP6fh9pFktY96h0Ix3cfkOsqVHOhQZBaSEIuLQzgr4zs8ZBJUjSvy42hkbQJTZCLp5TamTg6OWgRHb7Djzprr5KtJEP6wb")
    response = JSON.parse(Net::HTTP.get_response(uri))
    return response["name"]
end

Bot.on :message_echo do |message_echo|

    Reponse.create({
        sender_id: message_echo.sender['id'],
        message: message_echo.text
    })
    
    # message_echo.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
    # message_echo.sender      # => { 'id' => '1008372609250235' }
    # message_echo.seq         # => 73
    # message_echo.sent_at     # => 2016-04-22 21:30:36 +0200
    # message_echo.text        # => 'Hello, bot!'
    # message_echo.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  
    # Log or store in your storage method of choice (skynet, obviously)
end