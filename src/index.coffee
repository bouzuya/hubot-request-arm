{Promise} = require 'q'
cheerio = require 'cheerio'
request = require 'request'

module.exports = (params) ->
  format = params.format
  delete params.format
  new Promise (resolve, reject) ->
    request params, (err, res) ->
      return reject(err) if err?
      switch
        when format is 'html'
          try
            res.$ = cheerio.load res.body
          catch e
            reject e
        when format is 'json'
          try
            res.json = JSON.parse res.body
          catch e
            reject e
      resolve res
