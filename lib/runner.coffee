path = require 'path'
{spawn} = require 'child_process'


module.exports =
  class Runner

    constructor: (@view) ->

    run: ->
      return if @running or !atom.project.getPaths[0]?
      @running = true
      @setStatus('pending')

      try
        proc = spawn 'frigg', ['--failfast'], cwd: atom.project.getPaths()[0]

        proc.on 'close', (code) =>
          @running = false
          if code > 0
            @setStatus 'failure'
          else
            @setStatus 'success'

      catch err
        @running = false
        @setStatus 'failure'

    setStatus: (status) ->
      icons = { pending: 'icon-primitive-dot', success: 'icon-check', failure: 'icon-x' }
      icon = @view.find('.frigg-runner-status')
      icon.removeClass('icon-primitive-dot icon-check icon-x').addClass(icons[status])
      icon.removeClass('pending success failure').addClass(status)
