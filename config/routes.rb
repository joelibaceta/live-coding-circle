Rails.application.routes.draw do   

  root :to => 'snippets#stream'

  get 'snippet/:slug', to: 'snippets#show'
  get 'snippet/:slug/stream', to: 'snippets#stream', :as => :stream

  mount ActionCable.server => '/cable'
  #mount Facebook::Messenger::Server, at: "bot"
  
end
