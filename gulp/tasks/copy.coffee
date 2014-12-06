gulp = require('gulp')
config = require('../config')

gulp.task 'copy', ->
  gulp.src([
    "!#{config.appDir}/images/sprites"
    "#{config.appDir}/images/**/*"
    "#{config.appDir}/fonts/**/*"
  ], base: 'app/')
  .pipe(gulp.dest("#{config.publicDir}"))
