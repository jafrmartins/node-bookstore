del = require 'del'
gulp = require 'gulp'
shell = require 'gulp-shell'
{ config } = require './package'

require './tasks/mongod'
require './tasks/mocha'
require './tasks/node'

gulp.task 'clean', ->
  del(['./data'])
  del(['./node_modules'])

gulp.task 'install', [
  'install:mongod'
]

gulp.task 'start', [
  'start:mongod',
  'start:node'
]

gulp.task 'stop', [
  'stop:node',
  'stop:mongod'
]

gulp.task 'test', [
  'start:mocha'
  'watch:mocha'
]

gulp.task 'watch', [
  'watch:mocha',
  'watch:node'
]

gulp.task 'default', [
  'test'
]
