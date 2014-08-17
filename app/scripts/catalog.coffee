fs = require 'fs'

generateCatalog = (path)->
	html = '<div class="ui list link">'
	list = fs.readdirSync path
	for item in list
		subpath = path+'/'+item
		stats = fs.lstatSync subpath
		if stats.isDirectory()
			html += "<div class=\"item\" data-path=\"#{subpath}\"><i class=\"icon triangle right\"></i>#{item}#{generateCatalog(subpath)}</div>"
		else
			html += "<div class=\"item\" data-path=\"#{subpath}\"><i class=\"icon\"></i>#{item}</div>"
	html

class Catalog
	constructor : (wrap,root = editor.config.workplace)->
		this.wrap = $(wrap)
		this.root = root
		this.generate()

	generate : ()->
		html = generateCatalog(this.root)
		this.wrap.html html
		this.wrap.delegate '.item' ,'click' ,->
			$i = $(this).find('i:first');
			if $i.hasClass 'right'
				$i.removeClass('right').addClass('down')
			else if $i.hasClass 'down'
				$i.removeClass('down').addClass('right')
			return false

editor.Catalog = Catalog


