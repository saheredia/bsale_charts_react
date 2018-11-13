UI Base React
======================================
Codigo base para aplicaciones Sinatra+Webpack+Babel+ReacJS


**Curso ReacJS**
======================================
https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/content
```
user: mmunoz@imaginex.cl
pass: develop2018
secciones mas relevantes: 2 al 9, 13 al 16 y 20
```

**Instalacion de Dependencias Backend (Development o Produccion)**
```
rvm install 2.3.6
gem install bundle
bundle install
```

**Instalacion NPM, solo para Development (pasos en ubuntu)**
```
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install nodejs -y
```

**Instalacion de dependencias Frontend, solo para Development**
```
npm install
```

**Modo Development**
Para iniciar en development (se usa puerto 8080), ejecutar:
```
sh start_dev.sh 
```
Luego puedes acceder de tu navegador con: http://dns-instancia-aws:8080/ruta-sinatra


**IMPORTANTE**
Por cada nuevo controler.js se debera agregar un nuevo entry en webpack.config.js, con el formato:
```js
  entry: {
    /*--Rutas ya agregadas--*/
    example1: './app/views/example1/controller.js',
    example2: './app/views/example2/controller.js',
    example3: './app/views/example3/controller.js',    
    **concepto**: './app/views/**concepto**/controller.js'
  },
```
##TODO: que se agreguen automaticamente

**Modo Produccion**
Iniciar: `sh config/unicorn_init.sh start `

Detener: `sh config/unicorn_init.sh stop `

Actualizar: `sh config/unicorn_init.sh upgrade`
