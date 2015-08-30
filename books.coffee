{ Router } = require 'express'

mongoose = require 'mongoose'

router = new Router

{ Schema } = mongoose

schema = new Schema {
  title: { type: "String", required: true }
  author: { type: "String", required: true }
}

authors = mongoose.model 'books', schema

resource = require './resource'

router.get '/', resource.find.bind model: authors

router.post '/', resource.post.bind model: authors

router.get '/:id', resource.get.bind model: authors

router.put '/:id', resource.put.bind model: authors

router.delete '/:id', resource.delete.bind model: authors

module.exports = router
