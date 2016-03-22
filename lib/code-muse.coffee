{CompositeDisposable} = require 'atom'
cp = require 'chordplayer'
np = require 'noteplayer'
musicode = false

module.exports = CodeMuse =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'code-muse:toggle': => @toggle()

    atom.workspace.observeTextEditors (editor) ->
      editorView = atom.views.getView editor
      editorView.addEventListener 'keyup', keypressHandler = (event) ->
        playKey event.which

  deactivate: ->
    @subscriptions.dispose()


  toggle: ->
    console.log 'CodeMuse was toggled!'
    if !musicode
      musicode = true
      atom.notifications.addSuccess "Get Musicode!"
    else
      musicode = false
      atom.notifications.addSuccess "Shhh!"

g =  np.buildFromName "G4"
b =  np.buildFromName "B5"
c =  np.buildFromName "D5"
d =  np.buildFromName "F5"
e =  np.buildFromName "A6"
f =  np.buildFromName "C6"

playKey = (code) ->
  return if !musicode
  chord = switch code % 6
    when 0 then g
    when 1 then b
    when 2 then c
    when 3 then d
    when 4 then e
    else f
  chord.play()
