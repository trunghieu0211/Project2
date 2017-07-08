(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = '//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

$(document).ready(function() {
  $('.dialog').fadeTo(2000, 500).slideUp(2000, function(){
    $('.dialog').slideUp(2000);
  });

  $('.dialog-2').fadeTo(4000, 500).slideUp(2000, function(){
    $('.dialog-2').slideUp(2000);
  });
});
