require "facebook/messenger"
include Facebook::Messenger
require 'net/http'
require 'uri'
require 'json'

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

def GetAccessToken
    # url = URI("https://graph.facebook.com/v3.0/oauth/access_token? grant_type=fb_exchange_token&client_id=432596000483437&client_secret=270b172b42d4fccd6be9b5e9c8ae63f2&fb_exchange_token=#{ENV["ACCESS_TOKEN"]}&%20grant_type=fb_exchange_token")

    # http = Net::HTTP.new(url.host, url.port)

    # request = Net::HTTP::Get.new(url) 
    # response = JSON.parse(http.request(request).read_body)
    # return response["access_token"]
    return "EAAGJcZArwqG0BAOyj0tj4hhsPZBXzKCyIjccpm3BTU0YQ9qsZBoHshNEHR6EHtVNPUn6q0ZBQZCZCRv2qYBZAJMEwE3F2TZCXZBTcP2YNitqrQeH5UelTQEusD0gypdW33xZCZBFMU3jeyVnSciMOAx6IicbtZAcgFJta2dk8oYr7XJFOgZDZD"
end

def getname(id)
    uri = URI.parse("https://graph.facebook.com/#{id}?fields=first_name,last_name,profile_pic&access_token=EAAGJcZArwqG0BAAm1rK3iW2fBFMQGsiJ4No061CZAr21wngsiNDKzbcgYgoNkhop2pGZBriQjoQtKLVfLnNVx2l3uoZCBoTnO7QWHjJM3ZBubFYZClyE4PWoZCgogZBolD5TjrJwMJ5DGnMCtPB4vNViziUSmIzjg8VNXlmau0AVuwZDZD")
    request = Net::HTTP::Get.new(uri) 

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    json = JSON.parse(response.body)
    return "#{json["first_name"]} #{json["last_name"]}"
end

def BuildMessage(msg)
    
    uri = URI("https://graph.facebook.com/v3.0/me/message_creatives?access_token=EAAGJcZArwqG0BAAm1rK3iW2fBFMQGsiJ4No061CZAr21wngsiNDKzbcgYgoNkhop2pGZBriQjoQtKLVfLnNVx2l3uoZCBoTnO7QWHjJM3ZBubFYZClyE4PWoZCgogZBolD5TjrJwMJ5DGnMCtPB4vNViziUSmIzjg8VNXlmau0AVuwZDZD")

    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json" 
    request.body = JSON.dump({
        "messages" => [
            {
            "text" => msg
            }
        ]
    })
    
    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end

    json = JSON.parse(response.body)

    puts response.body
    return json["message_creative_id"]
end

def sendBroadcast(msg_id)
    uri = URI.parse("https://graph.facebook.com/v3.0/me/broadcast_messages?access_token=EAAGJcZArwqG0BAAm1rK3iW2fBFMQGsiJ4No061CZAr21wngsiNDKzbcgYgoNkhop2pGZBriQjoQtKLVfLnNVx2l3uoZCBoTnO7QWHjJM3ZBubFYZClyE4PWoZCgogZBolD5TjrJwMJ5DGnMCtPB4vNViziUSmIzjg8VNXlmau0AVuwZDZD")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Cache-Control"] = "no-cache"
    request["Postman-Token"] = "663c44f2-90da-4c5b-b383-f7c56aea20b8"
    request.body = JSON.dump({
        "message_creative_id" => msg_id,
        "notification_type" => "REGULAR",
        "messaging_type" => "MESSAGE_TAG",
        "tag" => "NON_PROMOTIONAL_SUBSCRIPTION"
    })

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
    end
    puts response.body
end


Bot.on :message do |message|
    
    sender = message.sender['id']

    Message.create({
        author: sender,
        body: message.text
    })
 
    puts "BUILDING MESSAGE"
    id_msg = BuildMessage("#{getname(sender)}: #{message.text}")
    puts "MESSAGE BUILDED: #{id_msg} "
    sendBroadcast(id_msg)


    
end
 
Bot.on :message_echo do |message_echo|

    sender = message_echo.sender['id'];
    Reponse.create({
        sender_id: sender.to_s,
        body: message_echo.text.to_s
    })
    
    # message_echo.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
    # message_echo.sender      # => { 'id' => '1008372609250235' }
    # message_echo.seq         # => 73
    # message_echo.sent_at     # => 2016-04-22 21:30:36 +0200
    # message_echo.text        # => 'Hello, bot!'
    # message_echo.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  
    # Log or store in your storage method of choice (skynet, obviously)
end