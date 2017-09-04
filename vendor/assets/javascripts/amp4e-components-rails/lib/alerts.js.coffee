# Displays alerts in colored banners at the top of the main view
class AMP4e.Alerts

  constructor: (options = {}) ->
    if options.container
      @$parentEl = $(options.container)
      if @$parentEl.find('.alerts-container').length == 0
        @$parentEl.prepend $('<div class="alerts-container"></div>')
      @$alertsContainer = @$parentEl.find('.alerts-container')
    else
      if $('#alerts-container').length == 0
        $('main').prepend $('<div id="alerts-container"></div>')
      @$alertsContainer = $('#alerts-container')
      @containerTop = if @$alertsContainer.length > 0 then @$alertsContainer.offset().top else 0

  success: (message) ->
    @_showAlert(message, 'success')

  info: (message) ->
    @_showAlert(message, 'info')

  warning: (message) ->
    @_showAlert(message, 'warning')

  error: (message) ->
    @_showAlert(message, 'error')

  clear: ->
    @$alertsContainer.empty()

  _showAlert: (message, type) ->
    @$alertsContainer.html JST['amp4e-components-rails/templates/alerts']({message, type})
    unless @$parentEl
# scroll alerts container into view if it's not currently visible
      window.scrollTo(0, @containerTop - 10) if window.pageYOffset > @containerTop
