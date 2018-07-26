require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
    

    message.reply(text: "Sender: " + message["sender"]["id"] )
end


Bot.on :message_echo do |message_echo|

    puts "MESSAGE ECHO:" 
    puts message_echo
    
    # message_echo.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
    # message_echo.sender      # => { 'id' => '1008372609250235' }
    # message_echo.seq         # => 73
    # message_echo.sent_at     # => 2016-04-22 21:30:36 +0200
    # message_echo.text        # => 'Hello, bot!'
    # message_echo.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  
    # Log or store in your storage method of choice (skynet, obviously)
end