gulp = require('gulp')
browserSync = require('browser-sync')
historyApiFallback = require('connect-history-api-fallback')
prism = require('connect-prism')
config = require('../config')

gulp.task 'browser-sync', ->
  prism.create(
    name: 'serve'
    mode: 'mock'
    context: '/temp_api'
    host: 'localhost'
    port: 8001
    delay: 0
    rewrite: {}
  )

  browserSync
    port: config.ports.server
    open: false
    notify: false
    server:
      baseDir: "#{config.publicDir}"
      middleware: [prism.middleware]
    files: [
      "#{config.publicDir}/**"
      "!#{config.publicDir}/**.map"
    ]
