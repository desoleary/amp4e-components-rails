describe 'AMP4e.Alerts', ->

  alerts = null

  fixture.set '<main></main>'

  beforeEach ->
    alerts = new AMP4e.Alerts()

  describe '#success', ->
    it 'displays a success alert', ->
      alerts.success 'Some message'
      expect(alerts.$alertsContainer.find('.alert-success').text()).to.include 'Some message'

  describe '#info', ->
    it 'displays an info alert', ->
      alerts.info 'Some message'
      expect(alerts.$alertsContainer.find('.alert-info').text()).to.include 'Some message'

  describe '#warning', ->
    it 'displays a warning alert', ->
      alerts.warning 'Some message'
      expect(alerts.$alertsContainer.find('.alert-warning').text()).to.include 'Some message'

  describe '#error', ->
    it 'displays an error alert', ->
      alerts.error 'Some message'
      expect(alerts.$alertsContainer.find('.alert-danger').text()).to.include 'Some message'

  describe '#clear', ->
    it 'clears an existing alert', ->
# first create something to clear
      alerts.info 'Some message'
      alerts.clear()
      expect(alerts.$alertsContainer.html()).to.eql ''
