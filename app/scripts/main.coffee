fs = require 'fs'

new editor.Catalog '#catalog'

$('#save').on 'click' , ->
	if editor.current == null
		# ...
	else
		fs.writeFileSync(editor.current, editor.ckeditor.getData())
		editor.changed = false

	
$('#close').on 'click',->
	if !editor.changed 
		editor.current = null
		editor.ckeditor.setData ''
		$('#title').val ''
	else
		alert 'has changed'