jQuery.noConflict();

var Plans = window.Plans = {};

var CSRFFix = (function($) {
  var csrfToken;

  // -*- private methods -*- //
  function beforeSend(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', csrfToken);
  }

  function init() {
    csrfToken = $('meta[name="csrf-token"]').attr('content');
  }

  // -*- attach events -*- //
  $(document).ready(init);

  $.ajaxSetup({ beforeSend: beforeSend });
})(jQuery);
