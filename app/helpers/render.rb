#Renderizado estilo Rails de parciales o templates
#uso:
# _render :partial => 'ruta/al/parcial'
# _render :partial => 'ruta/al/parcial' :locals => { :variable1 => 'valor', :variable2 => 'valor' }
# _render :template => 'ruta/a/la/vista', :layout => false
# _render :template => 'ruta/a/la/vista', :layout => :'layouts/loyalty'
def _render(*args)
  file = ""
  if args.first.has_key?(:partial)
    file = args.first[:partial].split('/')
    last = file.last
    file = file.join('/')
    file.gsub!(last, "_#{last}")
  end
  file = args.first[:template] if args.first.has_key?(:template)
  return '' if file.to_s.strip.length == 0
  layout = false 
  layout = :"/layouts/#{args.first[:layout]}".to_sym if args.first.has_key?(:layout)
  return erb :"#{file}".to_sym, :locals => args.first[:locals] , :layout => layout
end