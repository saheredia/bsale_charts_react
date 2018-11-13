module.exports = (env, argv) => ({
  entry: {
    example1: './app/views/example1/controller.js',
    example2: './app/views/example2/controller.js',
    example3: './app/views/example3/controller.js'
  },
  output: {
    filename: '[name]/controller.js',
    path: __dirname + '/public/javascripts/build/'
  },
  module: {
    rules: [
      { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
    ]
  },
  devtool: argv.mode === "development" ? "source-map" : false

})