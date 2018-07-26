require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
    message.reply(text: 'Your current snippet is:' + session[:current_snippet].to_s)
    
end
