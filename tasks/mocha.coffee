gulp = require 'gulp'
shell = require 'gulp-shell'
{ config } = require '../package'

gulp.task 'start:mocha', shell.task [
  "mocha --recursive --require coffee-script/register --compilers coffee:coffee-script/register -R spec spec/"
]

gulp.task 'watch:mocha', ->
  gulp.watch 'spec/**/*-spec.coffee', ['start:mocha']
