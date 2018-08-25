require_relative '../lib/pty_session_manager.rb'

class TerminalChannel < ApplicationCable::Channel

    @session = nil

    attr_accessor :channel

    def subscribed
        @semaphore = Mutex.new 
        term_session_name = "terminal_#{params[:session_id]}" 
        stream_from term_session_name 
    end

    def receive(data)
        slug = data["slug"]
        pty_session = PTYSessionManager.get_session(slug)
        pty_session.send_data(data["char"])
    end

    
    
end