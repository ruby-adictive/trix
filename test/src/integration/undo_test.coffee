editorModule "Undo/Redo", template: "editor_empty"

editorTest "typing and undoing", (done) ->
  first = editor.document.copy()
  typeCharacters "abc", ->
    ok not editor.document.isEqualTo(first)
    clickToolbarButton action: "undo", ->
      ok editor.document.isEqualTo(first)
      done()

editorTest "typing, formatting, typing, and undoing", (done) ->
  first = editor.document.copy()
  typeCharacters "abc", ->
    second = editor.document.copy()
    clickToolbarButton attribute: "bold", ->
      typeCharacters "def", ->
        third = editor.document.copy()
        clickToolbarButton action: "undo", ->
          ok editor.document.isEqualTo(second)
          clickToolbarButton action: "undo", ->
            ok editor.document.isEqualTo(first)
            clickToolbarButton action: "redo", ->
              ok editor.document.isEqualTo(second)
              clickToolbarButton action: "redo", ->
                ok editor.document.isEqualTo(third)
                done()
