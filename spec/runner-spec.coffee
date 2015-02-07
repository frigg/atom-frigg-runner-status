FriggRunnerStatusBarView = require '../lib/frigg-runner-status-view'
Runner = require '../lib/runner'

describe 'Runner', ->
  [view, runner, icon] = []

  beforeEach ->
    view = new FriggRunnerStatusBarView
    runner = new Runner view
    icon = view.find('.frigg-runner-status')

  describe '.setStatus()', ->
    it 'should set correct icon on set status', ->

      runner.setStatus('failure')
      expect(icon.hasClass('icon-x')).toBe(true)

      runner.setStatus('success')
      expect(icon.hasClass('icon-check')).toBe(true)

      runner.setStatus('pending')
      expect(icon.hasClass('icon-primitive-dot')).toBe(true)

    it 'should set correct color class', ->
      runner.setStatus('failure')
      expect(icon.hasClass('failure')).toBe(true)

      runner.setStatus('success')
      expect(icon.hasClass('success')).toBe(true)

      runner.setStatus('pending')
      expect(icon.hasClass('pending')).toBe(true)
