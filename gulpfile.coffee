gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
watch = require 'gulp-watch'
plumber = require 'gulp-plumber'

gulp.task 'watch', ['client', 'server'], ->
  watch glob: 'server/**/*.coffee'
  .pipe plumber()
  .pipe coffee({bare: true}).on('error', gutil.log)
  .pipe gulp.dest 'bin'
  
  watch glob: 'client/**/*.coffee'
  .pipe plumber()
  .pipe coffee({bare: true}).on('error', gutil.log)
  .pipe gulp.dest 'public/js'

gulp.task 'server', ->
  gulp.src 'server/**/*.coffee'
  .pipe coffee({bare: true}).on('error', gutil.log)
  .pipe gulp.dest 'bin'

gulp.task 'client', ->
  gulp.src 'client/**/*.coffee'
  .pipe coffee({bare: true}).on('error', gutil.log)
  .pipe gulp.dest 'public/js'

gulp.task 'default', ['client', 'server'], ->
