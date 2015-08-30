express = require 'express'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'
mkdirp = require 'mkdirp'
{ resolve } = require 'path'
{ writeFileSync: write } = require 'fs'
{ config } = require resolve process.cwd(), 'package.json'

process.on "uncaughtException", (err) -> console.log err

mongoose.connect config.mongodb_url

app = express()
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: true })
app.use '/api/v1/books', require './books'
app.listen config.express_port

mkdirp resolve config.express_path
pidfile = resolve config.express_path, config.express_pidfile
write pidfile, process.pid

module.exports = app
