(function() {
  var fs;

  fs = require('fs');

  new editor.Catalog('#catalog');

  $('#save').on('click', function() {
    if (editor.current === null) {

    } else {
      fs.writeFileSync(editor.current, editor.ckeditor.getData());
      return editor.changed = false;
    }
  });

  $('#close').on('click', function() {
    if (!editor.changed) {
      editor.current = null;
      editor.ckeditor.setData('');
      return $('#title').val('');
    } else {
      return alert('has changed');
    }
  });

}).call(this);
