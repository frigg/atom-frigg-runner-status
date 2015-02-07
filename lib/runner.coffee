path = require 'path'
{spawn} = require 'child_process'


module.exports =
  class Runner

    constructor: (@view) ->

    run: ->
      return if @running or !atom.project.path?
      @running = true
      @setStatus('pending')

      try
        proc = spawn('frigg', ['--failfast'], cwd: atom.project.path)
        proc.on 'close', (code) =>
          @running = false
          if code > 0
            @setStatus 'fail'
          else
            @setStatus 'success'

      catch err
        @running = false
        @setStatus 'fail'

    setStatus: (status) ->
      icons = { pending: 'icon-primitive-dot', success: 'icon-check', fail: 'icon-x' }
      icon = @view.find('.frigg-runner-status')
      icon.removeClass('icon-primitive-dot icon-check icon-x').addClass(icons[status])
      icon.removeClass('pending success fail').addClass(status)
