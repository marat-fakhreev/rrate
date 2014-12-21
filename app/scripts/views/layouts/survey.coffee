class SurveyLayout extends Marionette.LayoutView
  MOVING_DURATION = 800

  el: 'body'

  template: false

  ui:
    'formListButton': '.client-form .list li'
    'checker': '.checker'
    'checkbox': '.q-circle'
    'mapButton': '.map-buttons li'
    'arial': '.arial'
    'arrowButton': '.arrow'
    'question': '.question'
    'surveyTitle': '.survey-title'
    'surveyList': '.survey-list'
    'surveyCircles': '.survey-circles'

  events:
    'click @ui.formListButton': 'onChooseItem'
    'click @ui.checker': 'onClickChecker'
    'click @ui.checkbox': 'onClickCircle'
    'click @ui.mapButton': 'onClickMapButton'
    'click @ui.arrowButton': 'onClickArrowButton'
    'mousemove @ui.surveyTitle': 'onMoveClouds'

  onRender: ->
    @ui.wind = $(window)
    @ui.wind.on 'scroll', @onScrollPages

  onChooseItem: (event) ->
    self = $(event.currentTarget)
    self.siblings().removeClass('active')
    self.addClass('active')

  onClickChecker: (event) ->
    self = $(event.currentTarget)
    self.toggleClass('active')

  onClickCircle: (event) ->
    self = $(event.currentTarget)
    $itemsList = self.closest('.q-items')
    $itemsList.find('.q-circle').removeClass('active')
    self.addClass('active')

  onClickMapButton: (event) ->
    self = $(event.currentTarget)
    index = self.index()
    @ui.mapButton.removeClass('active')
    self.addClass('active')
    @ui.arial.removeClass('active')
    @ui.arial.eq(index).addClass('active')

  onClickArrowButton: (event) ->
    self = $(event.currentTarget)
    $currentQuestion = self.closest('.question')
    index = $currentQuestion.index()

    if self.hasClass('bottom-arrow')
      fromTop = $currentQuestion.offset().top + $currentQuestion.height() + 50
    else if self.hasClass('top-arrow')
      surveyItem = self.closest('.survey-item')

      if index isnt 0
        question = surveyItem.find('.question').prev()
        if question.index() is 0
          fromTop = surveyItem.find('.question').prev().offset().top - 150
        else
          fromTop = surveyItem.find('.question').prev().offset().top
      else
        fromTop = surveyItem.prev().find('.question').eq(-1).offset().top

    @$el.animate
      scrollTop: fromTop - 90
      MOVING_DURATION

  onMoveClouds: (event) ->
    self = $(event.currentTarget)
    $cloud = self.find('.cloud')
    $object = self.find('.move-object')
    @_setShift(event, $cloud.eq(0), 0.03, 0.015)
    @_setShift(event, $cloud.eq(1), 0.01, 0.03)
    @_setShift(event, $cloud.eq(2), -0.015, 0.015)
    @_setLinearShift(event, $object, 0.01, 0.01, $object.height())

  onScrollPages: =>
    fromTop = @ui.wind.scrollTop()

    if fromTop > @ui.surveyList.offset().top - 100
      @ui.surveyCircles.addClass('fixed')
    else
      @ui.surveyCircles.removeClass('fixed')

  _setShift: (event, $selector, xCoef, yCoef) ->
    $selector.css('background-position', "#{xCoef * event.pageX}px #{yCoef * event.pageY}px")

  _setLinearShift: (event, $selector, xCoef, yCoef, height) ->
    $selector.css({
      left: "#{xCoef * event.pageX}px"
    })


module.exports = SurveyLayout
