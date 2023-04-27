var webpack = require('webpack')

module.exports = {
  chainWebpack: config => {
    config.module.rules.delete('eslint');
    // File Loader
    config
      .module
      .rule("csv")
      .test(/\.csv$/)
      .use("file-loader")
        .loader("file-loader")
        .options({
          name: '[path][name].[ext]'
        })
        .end()
  },
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        'process.env.PACKAGE_JSON': '"' + escape(JSON.stringify(require('./package.json'))) + '"'
      })
    ],
    resolve: {
      alias: {
        'vue$': 'vue/dist/vue.runtime.esm-bundler.js'
      }
    }
  }
}
