class Application
  constructor: ->
    @initMessage = 'application started'

  start: ->
    console.log @initMessage

module.exports = new Application
