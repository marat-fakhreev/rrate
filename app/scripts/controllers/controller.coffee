LandingView = require('scripts/views/landing_view')

class Controller extends Marionette.Controller
  index: ->
    landingView = new LandingView()
    landingView.render()

module.exports = Controller
