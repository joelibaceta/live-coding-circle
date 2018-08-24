require_relative '../lib/session.rb'

class TerminalChannel < ApplicationCable::Channel

    @session = nil

    attr_accessor :channel

    def subscribed

        @semaphore = Mutex.new

        term_session_name = "terminal_#{params[:session_id]}"
 
        stream_from "terminal_#{params[:session_id]}"
 

        Thread.start do
            @semaphore.synchronize {
            
                ssh = Net::SSH.start('206.81.9.224', 'developer', password: "r3dc0d3")
        
                @channel = ssh.open_channel do |ch|
                     
                    ch.on_data do |ch, data|
                        ActionCable.server.broadcast(term_session_name, data)
                    end
                    ch.on_extended_data do |ch, type, data|
                        puts "stderr"
                    end
            
                    ch.request_pty
                    ch.send_channel_request("shell")  
                    ch.on_close { puts "done!" } 
            
                    end  
            
                    ssh.loop(0.1) {  
                        true 
                    } 
            } 
        end
        
    end

    def receive(data)
        @channel.send_data(data["char"]) if @channel
    end

  
end