(function() {
  var Catalog, fs, generateCatalog, path;

  fs = require('fs');

  path = require('path');

  generateCatalog = function(path) {
    var html, item, list, stats, subpath, _i, _len;
    html = '<div class="ui list link">';
    list = fs.readdirSync(path);
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      item = list[_i];
      subpath = path + '/' + item;
      stats = fs.lstatSync(subpath);
      if (stats.isDirectory()) {
        html += "<div class=\"item\" data-path=\"" + subpath + "\"><i class=\"icon triangle right\"></i>" + item + (generateCatalog(subpath)) + "</div>";
      } else {
        html += "<div class=\"item\" data-path=\"" + subpath + "\"><i class=\"icon\"></i>" + item + "</div>";
      }
    }
    return html;
  };

  Catalog = (function() {
    function Catalog(wrap, root) {
      if (root == null) {
        root = editor.workplace;
      }
      this.wrap = $(wrap);
      this.root = root;
      this.generate();
    }

    Catalog.prototype.generate = function() {
      var html;
      html = generateCatalog(this.root);
      this.wrap.html(html);
      return this.wrap.delegate('.item', 'click', function() {
        var $i, content, filename, filepath;
        $i = $(this).find('i:first');
        if ($i.hasClass('right')) {
          $i.removeClass('right').addClass('down');
        } else if ($i.hasClass('down')) {
          $i.removeClass('down').addClass('right');
        } else {
          filepath = $(this).data('path');
          filename = path.basename(filepath);
          content = fs.readFileSync(filepath, {
            encoding: "utf-8"
          });
          editor.ckeditor.setData(content);
          $('#title').val(filename);
          editor.current = filepath;
        }
        return false;
      });
    };

    return Catalog;

  })();

  editor.Catalog = Catalog;

}).call(this);
