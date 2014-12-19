Router = require('scripts/routers/router')
Controller = require('scripts/controllers/controller')

App = new Marionette.Application

App.navigate = (route, options) ->
  options or= {}
  Backbone.history.navigate(route, options)

App.on 'start', ->
  @controller = new Controller
  @router = new Router(controller: @controller)

  Backbone.history.start
    pushState: true
    root: '/'

module.exports = App
