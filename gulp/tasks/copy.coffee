gulp = require('gulp')
plumber = require('gulp-plumber')
config = require('../config')

gulp.task 'copy', ->
  gulp.src([
    "#{config.appDir}/images/**/*"
    "!#{config.appDir}/images/sprites"
    "#{config.appDir}/fonts/**/*"
  ], base: 'app/')
  .pipe(plumber())
  .pipe(gulp.dest("#{config.publicDir}"))
