(function() {
  var ckeditor;

  ckeditor = CKEDITOR.replace('ckeditor', {});

  ckeditor.on('instanceReady', function(event) {
    var editor;
    editor = event.editor;
    return setTimeout(function() {
      if (!editor.element) {
        setTimeout(arguments.callee, 100);
        return;
      }
      event.removeListener('instanceReady', this.callee);
      debugger;
      if (editor.name === 'ckeditor') {
        return editor.resize(editor.container.getStyle('width'), CKEDITOR.document.getById('cke_1_contents').getParent().$.offsetHeight);
      }
    }, 0);
  }, null, null, 9999);

  new editor.Catalog('#catalog');

}).call(this);
