{View} = require 'atom-space-pen-views'

module.exports =
  class FriggRunnerStatusBarView extends View

    initialize: ->
      if atom.workspaceView.statusBar
        @attach()
      else
        atom.packages.onDidActivateAll =>
          @attach()

    attach: ->
      atom.workspaceView.statusBar.appendLeft(this)

    @content: ->
      @div class: 'inline-block', =>
        @span outlet: 'friggRunnerStatus', title: 'frigg', class: 'frigg-runner-status icon icon-primitive-dot', tabindex: -1, ''
