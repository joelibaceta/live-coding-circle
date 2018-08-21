Rails.application.routes.draw do   

  root :to => 'snippets#stream'

  get 'snippet/:slug', to: 'snippets#show'
  get 'snippet/:slug/stream', to: 'snippets#stream', :as => :stream
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'
  mount Facebook::Messenger::Server, at: "bot"
  
end
