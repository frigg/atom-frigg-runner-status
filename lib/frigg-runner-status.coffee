{CompositeDisposable} = require 'atom'
FriggRunnerStatusBarView = require './frigg-runner-status-view'
Runner = require './runner'

module.exports =
  activate: ->
    @friggIcon = new FriggRunnerStatusBarView
    @runner = new Runner @friggIcon
    @disposables = new CompositeDisposable

    atom.workspace.eachEditor (editor) =>
      buffer = editor.getBuffer()

      @disposables.add buffer.onDidSave =>
        @runner.run()

  deactivate: ->
    @friggIcon?.destroy()
    @friggIcon = null
