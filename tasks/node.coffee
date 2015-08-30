gulp = require 'gulp'
shell = require 'gulp-shell'
{ config } = require '../package'

gulp.task 'stop:node', shell.task [
  "kill -9 $(cat #{config.express_path}/#{config.express_pidfile})"
]

gulp.task 'start:node', shell.task [
  "coffee index.coffee"
]

gulp.task 'watch:node', ->
  gulp.watch 'spec/*-spec.coffee', ['stop:node', 'start:node']
