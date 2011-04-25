// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function () {
    $('.file_upload').fileUploadUI({
        uploadTable: $('#files'),
        downloadTable: $('#files'),
        dropZone: $('#file_upload_container'),
        buildUploadRow: function (files, index) {
            return $('<tr><td>' + files[index].name + '<\/td>' +
                    '<td class="file_upload_progress"><div><\/div><\/td>' +
                    '<td class="file_upload_cancel">' +
                    '<\/td><\/tr>');
        },
        buildDownloadRow: function (file) {
          $("#list").show();
          $("#picture_title").val("") && $("#picture_description").val("");
          var picture_data =  '<tr><td><span class="best_in_place" id="best_in_place_picture_title" data-url="/pictures/' + file.id + '" data-object="picture" data-attribute="title" data-type="input">'  + file.title + '</span></td>' + 
                              '<td><span class="best_in_place" id="best_in_place_picture_description" data-url="/pictures/' + file.id + '" data-object="picture" data-attribute="description" data-type="textarea">'  + file.description + '</span></td>' +
                              '<td>' + file.name +'</td>' +
                              '<td><a rel="nofollow" data-method="delete" data-confirm="Are you sure?" href="/users/' + file.user + '/pictures/' + file.id+ '">'+ 'Destroy</a></td></tr>';
            $("#pictures").append(picture_data);
            $("#slots").html('<h1>' + file.size + ' slots left</h1>');
        },
        beforeSend: function (event, files, index, xhr, handler, callBack) {
          var title = $("#picture_title").val();
          var description = $("#picture_description").val();
          if (title === "" || description === "") {
            clientSideValidations.validateForm(".file_upload");
            handler.removeNode(handler.uploadRow);
          }
          else {
            if (files[index].size > 2000000) {
              handler.uploadRow.find('.file_upload_progress').html('FILE TOO BIG!');
              setTimeout(function () {
                handler.removeNode(handler.uploadRow);
              }, 20000);
              return;
            }
            else {
              var regexp = /\.(jpeg)|(jpg)$/i;
              if (!regexp.test(files[index].name)) {
                  handler.uploadRow.find('.file_upload_progress').html('ONLY IMAGES ALLOWED!');
                  setTimeout(function () {
                      handler.removeNode(handler.uploadRow);
                  }, 10000);
                  return;
              }
            }
            callBack();
          }
        },
        onComplete: function () {
          jQuery(".best_in_place").best_in_place();
          if ($('#pictures > tbody > tr').length > 4){
            $('#pictures > tbody > tr').last().remove();
            alert("You are allowed to upload a maximum of 3 pictures! Thank You!")
          }
          var slots_left = (4 - $('#pictures > tbody > tr').length)
          
          $("#picture_placeholder").hide();
        }
    });
});

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  var title = $("#picture_title").val();
  var description = $("#picture_description").val();
  if (title != "" && description != "") {
    $("#picture_title").val("") && $("#picture_description").val("");
  }
  if ($("#pictures_list table td").length == 0) {
    $("#list").hide();
  }
});


