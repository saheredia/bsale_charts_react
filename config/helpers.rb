class Helpers
  Sinatra::Base.helpers Sinatra::ContentFor
  Sinatra::Base.helpers Sinatra::Cookies
  Sinatra::Base.helpers Sinatra::OutputBuffer::Helpers
end
