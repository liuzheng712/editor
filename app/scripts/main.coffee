ckeditor = CKEDITOR.replace( 'ckeditor' , {
	# extraPlugins: 'autogrow'
	# autoGrow_maxHeight: 10000
	# removePlugins: 'resize'
} )

ckeditor.on 'instanceReady' , (event)->
	editor = event.editor
	setTimeout ->
		if !editor.element
			setTimeout arguments.callee,100
			return
		event.removeListener 'instanceReady' , this.callee
		debugger
		if editor.name == 'ckeditor'
			editor.resize( editor.container.getStyle( 'width' ), CKEDITOR.document.getById( 'cke_1_contents' ).getParent().$.offsetHeight )
	,0
,null,null,9999

new editor.Catalog '#catalog'