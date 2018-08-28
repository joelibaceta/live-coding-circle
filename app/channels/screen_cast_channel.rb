require_relative '../lib/screen_cast_manager.rb'

class ScreenCastChannel < ApplicationCable::Channel

    def subscribed
        stream_from "screencast_#{params[:hashcode]}"
    end

    def unsubscribed
        # Any cleanup needed when channel is unsubscribed
    end

    def receive(data)
        p data
        slug = params[:hashcode]
        screen_broadcast = ScreenCastManager.get_broadcast(params[:hashcode])
        screen_broadcast.send_data(data["canvas"])
    end

end