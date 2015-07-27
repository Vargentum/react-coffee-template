gulp     = require('gulp')
$        = require('gulp-load-plugins')()
config   = require('./config.json')



gulp.task 'scripts', ->
  gulp.src('./src/**/*.cjsx')
    .pipe($.plumber())
    .pipe($.concat('app.js'))
    .pipe($.cjsx(
      bare: on
    ))
    .pipe(gulp.dest('./app'))
    .pipe($.livereload())


gulp.task 'server', ->
  gulp.src('app')
    .pipe($.serverLivereload(
      host: config.server.host
      port: config.server.port
    ))


gulp.task 'watch', ->
  $.livereload.listen(
    quiet: on
  )
  $.watch('./src/**/*.cjsx', $.batch (cb) ->
    gulp.start('scripts')
    cb()
  )


gulp.task 'serve', [
  'scripts'
  'server'
  'watch'
]

gulp.task 'default', ['serve']