gulp =    require 'gulp'
compass = require 'gulp-compass'
coffee =  require 'gulp-coffee'
uglify =  require 'gulp-uglify'
concat =  require 'gulp-concat'
sass =    require 'gulp-sass'
rimraf =  require 'rimraf'
minify_css = require 'gulp-minify-css'
connect = require 'gulp-connect'
wiredep = require('wiredep').stream

$ = require('gulp-load-plugins')();

path = 
  scripts : 'app/scripts/**/*.{coffee,js}'
  styles  : 'app/styles/**/*.{scss,css}'
  images  : 'app/images'

##dev##
gulp.task 'scripts',->
  jsFilter = $.filter '{,**/}*.js'
  coffeeFilter = $.filter '{,**/}*.coffee'
  scripts_path = '.tmp/scripts'
  gulp.src(path.scripts)
    .pipe jsFilter
    .pipe $.changed scripts_path
    .pipe jsFilter.restore()
    .pipe coffeeFilter
    .pipe $.changed scripts_path , {extension : '.js'}
    .pipe $.coffee()
    .pipe coffeeFilter.restore()
    .pipe gulp.dest scripts_path
    .pipe $.size()
    .pipe connect.reload()


gulp.task 'styles',->
  styles_path = '.tmp/styles'
  sassFilter = $.filter '{,**/}*.scss'
  gulp.src path.styles
    .pipe sassFilter
    .pipe sass()
    .pipe sassFilter.restore()
    .pipe gulp.dest styles_path
    .pipe $.size()
    .pipe connect.reload()

gulp.task 'html',->
  gulp.src 'app/*.html'
    .pipe gulp.dest 'app/'
    .pipe connect.reload()

gulp.task 'connect',->
  connect.server {
    root : ['app','.tmp'],
    livereload:true,
    port:9000
  }

gulp.task 'watch' , ->
  gulp.watch path.scripts , ['scripts']
  gulp.watch path.styles  , ['styles']
  gulp.watch 'bower.json' , ['wiredep']
  gulp.watch 'app/*.html' , ['html']

gulp.task 'clean' , (cb)->
  rimraf './dist' ,cb

gulp.task 'wiredep' ,->
  gulp.src 'app/*.html'
    .pipe wiredep()
    .pipe gulp.dest 'app/'

gulp.task 'serve' ,['connect','watch','styles','scripts','html'] ,->
  require('opn') 'http://localhost:9000/'

##build##

gulp.task 'fonts',->
  $.bowerFiles()
    .pipe $.filter '**/*.{eot,svg,ttf,woff}'
    .pipe $.flatten()
    .pipe gulp.dest 'dist/fonts'
    .pipe $.size()

gulp.task 'build',['clean','styles','scripts','fonts'],->
  jsFilter = $.filter '**/*.js'
  cssFilter = $.filter '**/*.css'

  gulp.src 'app/*.html'
    .pipe $.useref.assets {searchPath : '{.tmp,app}'}
    .pipe jsFilter
    .pipe uglify()
    .pipe jsFilter.restore()
    .pipe cssFilter
    .pipe minify_css()
    .pipe cssFilter.restore()
    .pipe $.useref.restore()
    .pipe $.useref()
    .pipe gulp.dest 'dist'
    .pipe $.size()

  gulp.src ['app/*.*','!app/*.html'],{dot:true}
    .pipe  gulp.dest 'dist'

  gulp.src ['app/images/**/*.*',],{dot:true}
    .pipe  gulp.dest 'dist/images'

  gulp.src ['app/fonts/*.*',],{dot:true}
    .pipe  gulp.dest 'dist/fonts'

gulp.task 'default', ['build'],->
  connect.server {
      root : 'dist',
      port:80
  }
  require('opn') 'http://localhost/'