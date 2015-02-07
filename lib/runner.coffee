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
        proc.stdout.on 'data', (data) ->
          console.log data.toString()
        proc.stderr.on 'data', (data) ->
          console.error data.toString()
        proc.on 'close', (code) =>
          @running = false
          if code > 0
            @setStatus 'fail'
          else
            @setStatus 'success'

      catch err
        console.log err
        @running = false
        @setStatus 'fail'

    setStatus: (status) ->
      console.log status

      icons = { pending: 'icon-primitive-dot', success: 'icon-check', fail: 'icon-x' }
      icon = @view.find('.frigg-runner-status')
      icon.removeClass('icon-primitive-dot icon-check icon-x').addClass(icons[status])
      icon.removeClass('pending success fail').addClass(status)
