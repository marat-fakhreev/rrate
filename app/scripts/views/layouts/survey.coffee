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
    'surveyCircle': '.survey-circles .circle'
    'moveObject': '.move-object'

  events:
    'click @ui.formListButton': 'onChooseItem'
    'click @ui.checker': 'onClickChecker'
    'click @ui.checkbox': 'onClickQuestionCircle'
    'click @ui.mapButton': 'onClickMapButton'
    'click @ui.arrowButton': 'onClickArrowButton'
    'click @ui.surveyCircle': 'onClickSurveyCircle'
    'mousemove @ui.surveyTitle': 'onMoveClouds'

  onRender: ->
    @wind = $(window)
    @wind.on 'scroll', @onScrollScreen
    @_initSurveyCircles()

  onChooseItem: (event) ->
    self = $(event.currentTarget)
    self.siblings().removeClass('active')
    self.addClass('active')

  onClickChecker: (event) ->
    self = $(event.currentTarget)
    self.toggleClass('active')

  onClickQuestionCircle: (event) ->
    self = $(event.currentTarget)
    $itemsList = self.closest('.q-items')
    $itemsList.find('.q-circle').removeClass('active')
    self.addClass('active')

    if self.closest('.category').length isnt 0
      index = self.closest('.q-item').index()
      $list = self.closest('.question').find('ul')
      $list.find('.q-circle').removeClass('active')

      _.each $list.find('.q-item'), (value, key) ->
        $self = $(value)
        $self.find('.q-circle').addClass('active') if index is $self.index()

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
        $question = surveyItem.find('.question').prev()

        if $question.index() is 0
          fromTop = surveyItem.find('.question').prev().offset().top - 150
        else
          fromTop = surveyItem.find('.question').prev().offset().top
      else
        fromTop = surveyItem.prev().find('.question').eq(-1).offset().top

    @_moveFromTop(fromTop)

  onClickSurveyCircle: (event) ->
    self = $(event.currentTarget)
    index = self.index()
    fromTop = false
    @ui.surveyCircle.removeClass('active')
    self.addClass('active')

    _.each @ui.question, (value, key) ->
      $question = $(value)

      if index is key
        if $question.index() is 0
          fromTop = $question.offset().top - 150
        else
          fromTop = $question.offset().top

    @_moveFromTop(fromTop)

  onMoveClouds: (event) ->
    self = $(event.currentTarget)
    $cloud = self.find('.cloud')
    $object = self.find('.move-object')
    @_setShift(event, $cloud.eq(0), 0.03, 0.015)
    @_setShift(event, $cloud.eq(1), 0.01, 0.03)
    @_setShift(event, $cloud.eq(2), -0.015, 0.015)

  onScrollScreen: =>
    fromTop = @wind.scrollTop()

    if fromTop > @ui.surveyList.offset().top - 100
      @ui.surveyCircles.addClass('fixed')
    else
      @ui.surveyCircles.removeClass('fixed')

    _.each @ui.moveObject, (value, key) ->
      $self = $(value)
      offsetValue = fromTop - $self.closest('.survey-title').offset().top + 80
      $self.css('height', $self.data('height') + offsetValue * 0.57) if offsetValue >= 0

  _setShift: (event, $selector, xCoef, yCoef) ->
    $selector.css('background-position', "#{xCoef * event.pageX}px #{yCoef * event.pageY}px")

  _initSurveyCircles: ->
    count = @ui.question.length
    str = ''

    for i in [0...count]
      if i is 0
        str += "<li class='circle active'></li>"
      else
        str += "<li class='circle'></li>"

    @ui.surveyCircles.html(str)
    @bindUIElements()

  _moveFromTop: (fromTop) ->
    @$el.animate
      scrollTop: fromTop - 90
      MOVING_DURATION

module.exports = SurveyLayout
