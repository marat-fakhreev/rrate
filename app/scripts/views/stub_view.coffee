Timer = require('scripts/services/timer')

class StubView extends Marionette.ItemView
  el: 'body'

  template: false

  ui:
    form: '#stub_form'
    timer: '.timer'
    mailField: '.mail-field'
    labelFormBefore: '.label-form--before'
    labelFormAfter: '.label-form--after'

  events:
    'submit @ui.form': 'onFormSubmit'

  onRender: ->
    new Timer(@ui.timer)

  onFormSubmit: (event) ->
    event.preventDefault()
    mail = @ui.mailField.val()

    if $.trim(mail) isnt ''
      @model.save 'user_mail': mail,
        complete: =>
          @ui.labelFormBefore.removeClass('show')
          @ui.labelFormAfter.addClass('show')

module.exports = StubView
