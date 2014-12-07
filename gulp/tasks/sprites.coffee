gulp = require('gulp')
gulpif = require('gulp-if')
spritesmith = require('gulp.spritesmith')
config = require('../config')

gulp.task 'sprites', ->
  gulp.src("#{config.appDir}/images/sprites/**/*.png")
    .pipe(spritesmith(
      imgName: 'sprite.png'
      imgPath: 'images/sprite.png'
      cssName: 'sprite.styl'
      cssFormat: 'stylus'
      algorithm: 'binary-tree'
    ))
    .pipe(gulpif('*.styl', gulp.dest("#{config.appDir}/stylesheets/core/")))
    .pipe(gulpif('*.png', gulp.dest("#{config.publicDir}/images/")))
