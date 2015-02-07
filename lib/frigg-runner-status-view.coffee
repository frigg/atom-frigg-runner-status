{View} = require 'atom-space-pen-views'

module.exports =
  class FriggRunnerStatusBarView extends View

    initialize: ->
      atom.packages.onDidActivateInitialPackages =>
        statusBar = document.querySelector("status-bar")
        if statusBar?
          @statusBarTile = statusBar.addLeftTile(item: this, priority: 100)

    @content: ->
      @div class: 'inline-block', =>
        @span outlet: 'friggRunnerStatus', title: 'frigg', class: 'frigg-runner-status icon icon-primitive-dot', tabindex: -1, ''
