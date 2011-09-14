Plans.Edit = (function($) {
  // -*- private variables -*- //
  var planName
    , textarea
    , previewContents;
  ;

  function processPlan(plan, callback) {
    $.ajax('/'+planName+'/preview', {
      dataType: 'html',
      data: { contents: plan },
      success: callback
    });
  }

  function updatePreview(data) {
    previewContents.html(data);
  }

  function keyup() {
console.log('keyup', preview);
    processPlan(textarea.val(), updatePreview);
  }

  function init() {
    planName = window.location.pathname.split('/')[1];
    textarea = $('#edit textarea');
    previewContents = $('<div class="contents"></div>')

    $('<div id="preview"></div>')
      .prepend('<h2>Preview</h2>')
      .append(previewContents)
      .insertAfter(textarea)
    ;


    textarea.keyup(keyup);
    keyup();
  }

  $(document).ready(init);
})(jQuery);
