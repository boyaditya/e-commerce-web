const { defineConfig } = require('@vue/cli-service')
// const HtmlWebpackPlugin = require('html-webpack-plugin');
module.exports = defineConfig({
  transpileDependencies: true
})
// vue.config.js
module.exports = {
  configureWebpack: {
      module: {
          rules: [
              {
                  test: /\.ts$/,
                  use: [
                      'ts-loader',  
                  ],
                  exclude: /node_modules/,
              },
              {
                  test: /\.js$/,
                  loader: 'babel-loader',
                  exclude: /node_modules/,
              },
          ],
      },
  },
};

// module.exports = {
//     configureWebpack: {
//       plugins: [
//         new HtmlWebpackPlugin({
//           template: 'public/index.html', // Path ke template HTML utama
//           filename: 'index.html',
//           inject: true, // Menginjeksi skrip secara otomatis
//         }),
//       ],
//     },
//   };