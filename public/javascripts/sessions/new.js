Plans.Robohash = (function($) {
  function hash(text) {
    return (new jsSHA(text, 'ASCII')).getHash('SHA-256', 'HEX');
  }

  function robohashUrl(text) {
    return '//robohash.org/'+text+'.png?size=50x50';
  }

  function init() {
    var passwordField = $('#login input[type=password]')
      , img = $('#robohash img');
    ;
    
    passwordField.keyup(function() {
      img.attr('src', robohashUrl(hash(passwordField.val())));
    });
  }

  $(document).ready(init);
})(jQuery);
