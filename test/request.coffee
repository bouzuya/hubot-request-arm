assert = require 'power-assert'
sinon = require 'sinon'

describe 'request', ->
  beforeEach ->
    @sinon = sinon.sandbox.create()
    @request = require '../'

  afterEach ->
    @sinon.restore()

  describe 'server respond HTML', ->
    beforeEach ->
      {Request} = require 'request'
      @responseBody = '<html><head><title>TITLE</title></head></html>'
      @sinon.stub Request.prototype, 'init', (options) =>
        options.callback null, body: @responseBody

    describe 'format: undefined', ->
      it 'has body property', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
        .then (res) ->
          assert res.body?
          assert !res.json?
          assert !res.$?
        .then done, done

    describe 'format: "html"', ->
      it 'has $ property', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
          format: 'html'
        .then (res) ->
          assert res.body?
          assert !res.json?
          assert res.$?
          assert res.$('title').text() is 'TITLE'
        .then done, done

    describe 'format: "json"', ->
      it 'calls the onRejected with JSON.parse Error', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
          format: 'json'
        .then null, (e) ->
          assert.ok e
        .then done, done

  describe 'server respond JSON', ->
    beforeEach ->
      {Request} = require 'request'
      @responseBody = '{ "foo": "bar" }'
      @sinon.stub Request.prototype, 'init', (options) =>
        options.callback null, body: @responseBody

    describe 'format: undefined', ->
      it 'has body property', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
        .then (res) ->
          assert res.body?
          assert !res.json?
          assert !res.$?
        .then done, done

    describe 'format: "html"', ->
      it 'has $ property', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
          format: 'html'
        .then (res) ->
          assert res.body?
          assert !res.json?
          assert res.$?
        .then done, done

    describe 'format: "json"', ->
      it 'has json property', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
          format: 'json'
        .then (res) ->
          assert res.body?
          assert res.json?
          assert !res.$?
          assert res.json.foo is 'bar'
        .then done, done

  describe 'server respond Error', ->
    beforeEach ->
      {Request} = require 'request'
      @sinon.stub Request.prototype, 'init', (options) ->
        options.callback new Error('hoge')

    describe 'format: "json"', ->
      it 'calls the onRejected with an Error', (done) ->
        @request
          method: 'get'
          url: 'http://example.com/'
        .then null, (e) ->
          assert.ok e
          assert e.message is 'hoge'
        .then done, done
