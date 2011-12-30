Cubic::Application.routes.draw do
  resource :game
  root to: 'games#show'
end
