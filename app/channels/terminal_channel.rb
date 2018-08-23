require_relative '../lib/session.rb'

class TerminalChannel < ApplicationCable::Channel

    @session = nil
    @channel = nil

    attr_accessor :channel

    def subscribed
 
        stream_from "terminal_#{params[:session_id]}"

        @session = Session.new(params[:session_id])

        @session.ssh_connection = Session::SSHConnection.new(
            host: "206.81.9.224",
            user: "developer",
            password: "r3dc0d3"
        )

        @session.start()

        @channel = @session.current_session.open_channel do  |ch|

            puts ch 

            ch.on_data do |ch, data|
                #puts data
                ActionCable.server.broadcast("terminal_#{params[:session_id]}", data)
            end
        
            ch.on_extended_data do |ch, type, data|
                puts "stderr"
            end
        
            ch.on_close { puts "done!" }

            ch.request_pty

            ch.send_channel_request("shell")

            puts self
            
        end 
 
        @session.current_session.loop
        
    end

    def receive(data)  
        puts @channel 
        puts data
        p @channel.send_data(data["char"]) if @channel
    end

    

    # def define_dynamic_method(name, &block)
    #     (class << self; self; end).class_eval do
    #         define_method name, &block
    #     end
    # end
  
end