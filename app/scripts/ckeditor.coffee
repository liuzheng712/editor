editor.ckeditor = CKEDITOR.replace( 'ckeditor' , {
	# extraPlugins: 'autogrow'
	# autoGrow_maxHeight: 10000
	# removePlugins: 'resize'
} )

editor.ckeditor.on 'instanceReady' , (event)->

	editor = event.editor
	editor.resize( editor.container.$.parentElement.clientWidth, editor.container.$.parentElement.clientHeight )

editor.ckeditor.on 'change' , (event)->
	editor.changed = true


,null,null,9999

$(window).on 'resize' ,->
	editor.ckeditor.resize editor.ckeditor.container.$.parentElement.clientWidth , editor.ckeditor.container.$.parentElement.clientHeight