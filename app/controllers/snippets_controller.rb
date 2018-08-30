require_relative '../lib/pty_session_manager.rb' 

class SnippetsController < ApplicationController

  skip_before_action :verify_authenticity_token  
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]

  # GET /snippets/1
  # GET /snippets/1.json
  def show
      @snippet = Snippet.find_by slug: params[:slug]
  end 

  def stream
    
    @snippet = Snippet.find_by slug: params[:slug]

    
    unless @snippet
      @snippet = Snippet.new
      @snippet.language = "ruby"
      @snippet.slug = params[:slug] || SecureRandom.alphanumeric(8)
      @snippet.title = "untitled"
      @snippet.save

      redirect_to stream_path(slug: @snippet.slug)
    end

    # unless PTYSessionManager.get_session(@snippet.slug)
    #   @pty_session = PTYSessionManager.start_session(@snippet.slug)
    #   @pty_session.start(
    #     on_data: lambda {|data| ActionCable.server.broadcast("terminal_#{@snippet.slug}", data)}
    #   )
    # end

    unless ContainerEngine.get_container(@snippet.slug)
      @container = ContainerEngine.start_container(@snippet.slug, @snippet.language)
      @container.start
    end


end

  # GET /snippets/new
  def new
    @snippet = Snippet.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find_by slug: params[:slug]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:id, :code, :title, :language, :stack, :slug)
    end
end
