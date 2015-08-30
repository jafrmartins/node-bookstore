module.exports =

  find: (req, res) ->

    @model.find (err, data) ->

      if not err then return res.json data

      console.log err

  get: (req, res) ->

    @model.findById req.params.id, (err, data) ->

      if not err then return res.json data

      console.log err

  put: (req, res) ->

    @model.findById req.params.id, (err, data) ->

      Object.keys(req.body).map (k) ->

        data[k] = req.body[k]

      data.save (err) ->

        if not err then return res.json data

        console.log err

  post: (req, res) ->

    model = new @model req.body

    model.save (err) ->

      if not err then return res.json model.toJSON()

      console.log err

  delete: (req, res) ->

    @model.findById req.params.id, (err, data) ->

      data.remove (err) ->

        if not err then return res.json data

        console.log err
