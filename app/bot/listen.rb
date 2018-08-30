require "facebook/messenger"
include Facebook::Messenger
require 'net/http'
require 'uri'
require 'json'

@accesstoken = "EAAGJcZArwqG0BAN55iyPZAaJN7lmImcLLpP3fgbZBdYb9U60iOcWJkG6ys3Uit2KWFHdG0jZBKXL9ZAVBCXMOGHjXQn0RWFdHZAxZAnQ123ap9ZBVuZBqQPGZCeFZBb2ZAgx10bSPAPzEutphMs3Fj6xIpEtzluFRehlAmXZC1lQuZAWXbYQZDZD"


Facebook::Messenger::Subscriptions.subscribe(access_token: @accesstoken)

def getname(id)
    uri = URI.parse("https://graph.facebook.com/#{id}?fields=first_name,last_name,profile_pic&access_token=" + @accesstoken)
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
    
    uri = URI("https://graph.facebook.com/v3.0/me/message_creatives?access_token=" + @accesstoken)

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
    uri = URI.parse("https://graph.facebook.com/v3.0/me/broadcast_messages?access_token=" + @accesstoken)
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
 
    puts "BUILDING MESSAGE"
    id_msg = BuildMessage("#{getname(sender)}: #{message.text}")
    puts "MESSAGE BUILDED: #{id_msg} "
    sendBroadcast(id_msg)

    
end
  