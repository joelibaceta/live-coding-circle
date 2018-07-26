require "facebook/messenger"
include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
    message.reply(text: 'Your current snippet is:' + session[:current_snippet])
end

Bot.on :referral do |referral|
    # referral.sender    # => { 'id' => '1008372609250235' }
    # referral.recipient # => { 'id' => '2015573629214912' }
    # referral.sent_at   # => 2016-04-22 21:30:36 +0200
    # referral.ref       # => 'MYPARAM'
    
    user = User.find_by(sender_id: referral.sender) 
    user = User.create({sender_id: referral.sender, sender_id: referral.ref}) unless  user 
    user.sender_id = referral.ref 
    user.save

    
    
end