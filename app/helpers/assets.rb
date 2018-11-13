#Direccion de assets
#Si se esta en ambiente development, se obtendran locales, de lo contrario de desde CloudFront
#Cada modificacion al contenido de la carpeta /public requiere que se ejecute "sh assets_to_s3.sh"


def assets_url
  return ""
  #DEFINIR RUTA CLOUD FRONT Y LUEGO ACTIVAR
  #return "" if UiService.settings.app_environment.to_s == "development"
  #return "https://dojiw2m9tvv09.cloudfront.net/assets" if UiService.settings.app_environment.to_s == "production"
end

def fav_icon_tag(icon)
  assets_version = UiService.settings.app_environment.to_s == "production" ? UiService.settings.assets_version : Time.now.to_i
  return "<link rel='icon' href='#{assets_url}/#{icon}?#{assets_version}'>"
end

def stylesheet_tag(css)
  assets_version = UiService.settings.app_environment.to_s == "production" ? UiService.settings.assets_version : Time.now.to_i
  return "<link rel='stylesheet' href='#{assets_url}/stylesheets/#{css}?#{assets_version}' charset='utf-8' />"
end

def javascript_tag(js)
  assets_version = UiService.settings.app_environment.to_s == "production" ? UiService.settings.assets_version : Time.now.to_i
  return "<script src='#{assets_url}/javascripts/#{js}?#{assets_version}'></script>"
end
