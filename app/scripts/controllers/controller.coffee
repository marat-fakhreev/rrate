Mail = require('scripts/models/mail')
LandingView = require('scripts/views/landing_view')
StubView = require('scripts/views/stub_view')
SurveyLayout = require('scripts/views/layouts/survey')

class Controller extends Marionette.Controller
  index: ->
    landingView = new LandingView()
    landingView.render()

  stub: ->
    mail = new Mail()

    stubView = new StubView(model: mail)
    stubView.render()

  questions: ->
    surveyLayout = new SurveyLayout()
    surveyLayout.render()

module.exports = Controller
