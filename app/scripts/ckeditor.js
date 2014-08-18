(function() {
  editor.ckeditor = CKEDITOR.replace('ckeditor', {});

  editor.ckeditor.on('instanceReady', function(event) {
    var editor;
    editor = event.editor;
    return editor.resize(editor.container.$.parentElement.clientWidth, editor.container.$.parentElement.clientHeight);
  });

  editor.ckeditor.on('change', function(event) {
    return editor.changed = true;
  }, null, null, 9999);

  $(window).on('resize', function() {
    return editor.ckeditor.resize(editor.ckeditor.container.$.parentElement.clientWidth, editor.ckeditor.container.$.parentElement.clientHeight);
  });

}).call(this);
