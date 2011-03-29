// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// $(function () {
//     $('#file_upload').fileUploadUI({
//         uploadTable: $('#files'),
//         downloadTable: $('#files'),
//         dropZone: $('#file_upload_container'),
//         buildUploadRow: function (files, index) {
//             return $('<tr><td>' + files[index].name + '<\/td>' +
//                     '<td class="file_upload_progress"><div><\/div><\/td>' +
//                     '<td class="file_upload_cancel">' +
//                     '<button class="ui-state-default ui-corner-all" title="Cancel">' +
//                     '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
//                     '<\/button><\/td><\/tr>');
//         },
//         buildDownloadRow: function (file) {
//             return $('<tr><td><img alt="Photo" width="80" height="80" src="' + file.pic_path + '">' + file.name + '<\/td><\/tr>');
//         }
//     });
// });


// $('#file_upload').fileUploadUI({
//     uploadTable: $('#files'),
//     downloadTable: $('#files'),
//     buildUploadRow: function (files, index) {
//         return $('<tr><td class="file_upload_preview"><\/td>' +
//                 '<td>' + files[index].name + '<\/td>' +
//                 '<td class="file_upload_progress"><div><\/div><\/td>' +
//                 '<td class="file_upload_start">' +
//                 '<button class="ui-state-default ui-corner-all" title="Start Upload">' +
//                 '<span class="ui-icon ui-icon-circle-arrow-e">Start Upload<\/span>' +
//                 '<\/button><\/td>' +
//                 '<td class="file_upload_cancel">' +
//                 '<button class="ui-state-default ui-corner-all" title="Cancel">' +
//                 '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
//                 '<\/button><\/td><\/tr>');
//     },
//     buildDownloadRow: function (file) {
//         return $('<tr><td>' + file.name + '<\/td><\/tr>');
//     },
//     beforeSend: function (event, files, index, xhr, handler, callBack) {
//         handler.uploadRow.find('.file_upload_start button').click(callBack);
//     }
// });
// 
// $('#start_uploads').click(function () {
//     $('.file_upload_start button').click();
// });
