gulp = require 'gulp'
shell = require 'gulp-shell'
{ config } = require '../package'
{ mongodb_path } = config

gulp.task 'start:mongod', shell.task [
  "mongod --config #{mongodb_path}/mongodb.conf"
]

gulp.task 'stop:mongod', shell.task [
  "kill -9 $(cat #{mongodb_path}/mongod.lock)"
]

gulp.task 'install:mongod', shell.task [
  """
  [ -d #{mongodb_path} ] || mkdir -p #{mongodb_path} \
  && [ -f #{mongodb_path}/mongodb.conf ] || echo "

  # #{(new Date()).toString()}

  dbpath=#{mongodb_path}
  logpath=#{mongodb_path}/mongodb.log

  " >> #{mongodb_path}/mongodb.conf
  """
]
