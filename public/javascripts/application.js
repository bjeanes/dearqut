$(function() {
  $('.controls span a').click(vote);
});

function vote() {
  var span      = $(this.parentNode);
  var id        = span.parent().get(0).id.split('-')[1];
  var direction = span.is('.up') ? 'up' : 'down';
  var url       = "/messages/" + id + "/vote/" + direction;
  
  $.post(url, {}, voteCallback, 'json');
}

function voteCallback(data) {
  for (var i = data.length - 1; i >= 0; i--){
    var num = $('#controls-' + data[i].id + ' .num');
    console.log(num);
    num.text(data[i].rating);
  };
}
