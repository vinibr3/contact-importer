// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

$(function() {
  $("#sortable-headers").sortable({
    update: function(event, ui) {
      var sortedIDs = $("#sortable-headers").sortable("toArray");

      $('input#import_headers').val(sortedIDs)
    }
  });
});
