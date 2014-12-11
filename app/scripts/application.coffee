class Application
  MOVING_DURATION = 800

  constructor: ->
    @initUi()
    @events()

    winHeight = @_windowHeight()
    @_setHead(winHeight)
    @fromTop = winHeight
    @offsetArray = @_calcOffsetArray()

  initUi: ->
    @ui =
      wind: $(window)
      body: $('body, html')
      header: $('header')
      footer: $('footer')
      head: $('.head')
      headPicture: $('.head-picture')
      page: $('.js-page')
      menuButton: $('nav li')
      mapButton: $('.map-buttons li')
      plane: $('.plane')
      layerOne: $('.layer-one')
      layerTwo: $('.layer-two')
      layerThree: $('.layer-three')
      layerFour: $('.layer-four')
      layerFive: $('.layer-five')

  events: ->
    @ui.wind.on 'scroll', @onScrollHeader
    @ui.wind.on 'scroll', @onScrollPages
    @ui.menuButton.on 'click', @onMoveToScreen
    @ui.mapButton.on 'click', @onClickMapButton
    @ui.body.on 'mousemove', @onMoveHeadBackground

  onScrollHeader: =>
    if @ui.wind.scrollTop() < @fromTop
      @ui.header.removeClass('displayed')
      @ui.footer.removeClass('displayed')
    else
      @ui.header.addClass('displayed')
      @ui.footer.addClass('displayed')

  onScrollPages: =>
    fromTop = @ui.wind.scrollTop()

    _.each @offsetArray, (value, key) =>
      if fromTop > value - 200 and fromTop < @offsetArray[key + 1]
        @ui.menuButton.removeClass('active').eq(key).addClass('active')

  onMoveToScreen: (event) =>
    self = $(event.currentTarget)
    index = self.index()
    fromTop = @ui.page.eq(index).offset().top

    @ui.body.animate
      scrollTop: fromTop
      MOVING_DURATION
    , =>
      @ui.menuButton.removeClass('active')
      self.addClass('active')

  onClickMapButton: (event) =>
    self = $(event.currentTarget)
    index = self.index()
    $map = self.closest('.map')

    @ui.mapButton.removeClass('active')
    self.addClass('active')
    $map.find('.schemes li').removeClass('active').eq(index).addClass('active')

  onMoveHeadBackground: (event) =>
    @_setShift(event, @ui.layerTwo, 0.003, 0)
    @_setShift(event, @ui.layerThree, 0.01, 0)
    @_setShift(event, @ui.layerFour, -0.015, 0.015)
    @_setShift(event, @ui.layerFive, -0.015, -0.015)
    @_setLinearShift(event, @ui.plane, 0.1)

  _setShift: (event, $selector, xCoef, yCoef) ->
    $selector.css('background-position', "#{xCoef * event.pageX}px #{yCoef * event.pageY}px")

  _setLinearShift: (event, $selector, xCoef) ->
    $selector.css({
      bottom: "#{500 + xCoef / 5 * event.pageX}px",
      left: "#{200 + xCoef * event.pageX}px"
    })

  _windowHeight: ->
    @ui.wind.height()

  _calcOffsetArray: ->
    array = []

    _.each @ui.page, (value, key) ->
      array.push($(value).offset().top)

    array.push(Number.MAX_SAFE_INTEGER)
    array

  _setHead: (height) ->
    @ui.head.css('height': height)
    @ui.headPicture.css('height': height - 60)

module.exports = Application
