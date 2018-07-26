require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: "EAAGJcZArwqG0BAE8vwG8C9PSsNerkqCqvj8RJWgYWQJRO8ueftYVPRwl2pwTx383cZCMzfEwx3MNHZAn6UDMSvhg584kxoqV2HRKnAs3H1uloOZAWTJjnOZBpbQMLlZB6FlM2RRUHq6vgDK42seCiNjyfZAVhFBpFpuHnzo5xDiNAZDZD")

Bot.on :message do |message|
  puts "got your message!"
end