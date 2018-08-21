require_relative '../lib/session.rb'

class TerminalChannel < ApplicationCable::Channel

    @session = nil
    attr_accessor :channel

    def subscribed
        @channel = []
        stream_from "terminal_#{params[:session_id]}"
        @session = Session.new(params[:session_id])
        @session.ssh_connection = Session::SSHConnection.new(
            host: "206.81.9.224",
            user: "developer",
            password: "r3dc0d3"
        )
        puts self
        @session.start(self, params[:session_id], @channel)
        puts @channel[0]
    end
 
    def receive(data) 
        @channel[0].send_data(data["char"])
    end
end