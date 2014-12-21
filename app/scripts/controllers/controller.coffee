Mail = require('scripts/models/mail')
LandingView = require('scripts/views/landing_view')
StubView = require('scripts/views/stub_view')

class Controller extends Marionette.Controller
  index: ->
    landingView = new LandingView()
    landingView.render()

  stub: ->
    model = new Mail()

    stubView = new StubView(model: model)
    stubView.render()

module.exports = Controller
