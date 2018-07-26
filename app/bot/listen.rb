require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: "")

Bot.on :message do |message|
  puts "got your message!"
end