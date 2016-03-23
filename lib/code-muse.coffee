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
      atom.notifications.addSuccess "Type some keys to play!"
    else
      musicode = false
      atom.notifications.addSuccess "Shhh!"


# nodeplayer only allows for 6 notes at a time
notes = (np.buildFromName note for note in ["Ab4", "C4", "Eb4", "G4", "C5", "Eb5"])

# plays a note given a key code
playKey = (code) ->
  return if !musicode
  console.log notes[0]
  notes[code % 6].play()
