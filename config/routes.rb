class Routes
  # Rutas obligatorias
  #Sinatra::Base.register Sinatra::AdvancedRoutes
  # Rutas Disponibles
  Sinatra::Base.register Sinatra::Controllers::Goto
  Sinatra::Base.register Sinatra::Controllers::Example
  Sinatra::Base.register Sinatra::Controllers::Charts
  Sinatra::Base.register Sinatra::Controllers::Facebook

end
