Rails.application.routes.draw do
  get 'devices/:ip' => 'devices#index', :constraints => { :ip => /[0-9\-\.]+/ }
  post 'addresses/assign/' => 'addresses#assign', :constraints => { :ip => /[0-9\-\.]+/, :device => /[a-zA-Z0-9]+/ }
  root 'devices#index' 

end
