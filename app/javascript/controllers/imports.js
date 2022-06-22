$(function() {
  $("#sortable-headers").sortable({
    update: function(event, ui) {
      var sortedIDs = $("#sortable-headers").sortable("toArray");
      
      $('input#import_headers').val(sortedIDs)
    }
  });
});
