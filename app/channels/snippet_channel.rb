class SnippetChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)

    ActionCable.server.broadcast("chat_#{params[:room]}", data)
    
    if (data["event"] != "updateContent")
      @snippet = Snippet.find_by slug: data["slug"]
      @snippet.code = data["body"]
      @snippet.theme = data["theme"]
      @snippet.language = data["language"]
      @snippet.save
    end

    
  end
  
end
