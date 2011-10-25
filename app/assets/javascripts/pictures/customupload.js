(function ($) {
    'use strict';

  $.widget('blueimpUIX.fileupload', $.blueimpUI.fileupload, {

      options: {
          errorMessages: {
              maxFileSize: 'File is too big',
              minFileSize: 'File is too small',
              acceptFileTypes: 'Filetype not allowed',
              maxNumberOfFiles: 'Max number of files exceeded'
          }
      },

      _renderUploadTemplate: function (files) {
          var that = this,
              rows = $();
          $.each(files, function (index, file) {
              file = that._uploadTemplateHelper(file);
              var row = $('<tr class="template-upload">' + 
                  '<td class="preview"></td>' +
                  '<td class="name"></td>' +
                  '<td class="size"></td>' +
                  (file.error ?
                      '<td class="error" colspan="2"></td>'
                  :
                      '<td class="progress"><div></div></td>' +
                      '<td class="start"><button>Start</button></td>'
                  ) + 
                  '<td class="cancel"><button>Cancel</button></td>' +
                  '</tr>');
              row.find('.name').text(file.name);
              row.find('.size').text(file.sizef);
              if (file.error) {
                  row.addClass('ui-state-error');
                  row.find('.error').text(
                      that.options.errorMessages[file.error] || file.error
                  );
              }
              rows = rows.add(row);
          });
          return rows;
      }

  });
  
}(jQuery));