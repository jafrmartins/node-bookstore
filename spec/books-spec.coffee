request = require 'request-json'

{ parallel } = require 'async'

{ expect } = require 'chai'

{ resolve } = require 'path'

{ config } = require resolve process.cwd(), 'package.json'

client = request.createClient(
  "http://localhost:#{config.express_port}/api/v1/"
)

books = [
  { "author": "Aldous Huxley", "title": "A Brave New World" }
  { "author": "Aldous Huxley", "title": "Return to A Brave New World" }
]

describe 'Books', ->

  beforeEach (done) ->
    client.get "books/", (err, res, body) ->
      if err then return console.log err

      calls = ( body?.map (book) ->
        (next) ->
          client.del "books/#{book._id}", (err, res, body) ->
            if err then console.log err
            next err, book._id
      ) or []

      parallel calls, (err, data) ->
        if err then return done err, null
        done null, data

  it 'GET /books', (done) ->
    client.get "books/", (err, res, body) ->
      expect(body).to.deep.equal([])
      done()

  it 'POST /books', (done) ->
    client.post "books/", books[0],  (err, res, body) ->
      expect(body.title).to.equal books[0].title
      expect(body.author).to.equal books[0].author
      expect(typeof body._id).to.equal "string"
      done()

  it 'GET /books/:id', (done) ->
    client.post "books/", books[0],  (err, res, body) ->
      book = body
      client.get "books/#{book._id}", (err, res, body) ->
        expect(body).to.deep.equal book
        done()

  it 'PUT /books/:id', (done) ->
    client.post "books/", books[0],  (err, res, body) ->
      book = body
      book.title = "Return to A Brave New World"
      client.put "books/#{book._id}", book, (err, res, body) ->
        expect(body).to.deep.equal book
        done()

  it 'DEL /books/:id', (done) ->
    client.post "books/", books[0],  (err, res, body) ->
      book = body
      client.del "books/#{book._id}", (err, res, body) ->
        expect(body).to.deep.equal book
        done()

  after (done) ->
    calls = ( books.map (book) ->
      (next) ->
        client.post "books/", book, (err, res, body) ->
          if err then console.log err
          next err, body._id
    ) or []

    parallel calls, (err, data) ->
      if err then return done err, null
      client.get "books/", (err, res, body) ->
        expect(body.length).to.equal(books.length)
        done null, data
