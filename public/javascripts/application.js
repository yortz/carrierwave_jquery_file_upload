// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function () {
    $('#file_upload').fileUploadUI({
        uploadTable: $('#files'),
        downloadTable: $('#files'),
        dropZone: $('#file_upload_container'),
        buildUploadRow: function (files, index) {
            return $('<tr><td>' + files[index].name + '<\/td>' +
                    '<td class="file_upload_progress"><div><\/div><\/td>' +
                    '<td class="file_upload_cancel">' +
                    '<button class="ui-state-default ui-corner-all" title="Cancel">' +
                    '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
                    '<\/button><\/td><\/tr>');
        },
        buildDownloadRow: function (file) {
            return $('<tr><td><img alt="Photo" width="80" height="80" src="' + file.pic_path + '">' + file.name + '<\/td><\/tr>');
        },
        beforeSend: function (event, files, index, xhr, handler, callBack) {
          var title = $("#picture_title").val();
          var description = $("#picture_description").val();
          if (title == "" || description == "") {
            clientSideValidations.validateForm("#file_upload");
            handler.removeNode(handler.uploadRow);
          }
          else {
            callBack();
          }
        },
        onComplete: function () {
          $("#file_upload_container").hide();
        }
    });
});
