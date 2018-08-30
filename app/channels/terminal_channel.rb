require_relative '../lib/pty_session_manager.rb'

class TerminalChannel < ApplicationCable::Channel

    @session = nil

    attr_accessor :channel

    def subscribed 
        term_session_name = "terminal_#{params[:session_id]}" 
        stream_from term_session_name
    end

    def receive(data)
        slug = data["slug"]
        # pty_session = PTYSessionManager.get_session(slug)
        # pty_session.send_data(data["char"])
        container = ContainerEngine.get_container(slug)
        container.putc(data["char"])
        ActionCable.server.broadcast("terminal_#{slug}", container.gets)
    end

    def unsubscribed
        session_id = params[:session_id]
        #PTYSessionManager.get_session(session_id).close
    end

    
    
end