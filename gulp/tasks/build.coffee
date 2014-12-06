gulp = require('gulp')
runSequence = require('run-sequence')

gulp.task 'build', ->
  runSequence(
    'install'
    'clean'
    'sprites'
    [
      'copy'
      'templates'
      'stylesheets'
      'jsonlint'
      'coffeelint'
    ]
    'browserify'
    'browser-sync'
    'watch'
  )
