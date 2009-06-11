$(function() {
  $("input.autobox.tags").autobox({
    ajax: "/tags",
    match: function(typed) { return this.name.match(new RegExp(typed, "i")); },
    insertText: function(obj) { return obj.name; },
    templateText: "<li><%= name %> (<%= taggings_count %>)</li>"
  });
  
  $('ul.autobox-hldr').click(function() { 
    $('li.autobox-input input', this).focus(); 
  });
    
  $('.controls span a').click(vote);
});

function vote() {
  var span      = $(this.parentNode);
  var id        = span.parent().get(0).id.split('-')[1];
  var direction = span.is('.up') ? 'up' : 'down';
  var url       = "/messages/" + id + "/vote/" + direction;
  
  $.post(url, {}, voteCallback, 'json');
  
  return false;
}

function voteCallback(data) {
  for (var i = data.length - 1; i >= 0; i--){
    var up_num = $('#controls-' + data[i].id + ' .up num');
    var down_num = $('#controls-' + data[i].id + ' .down num');
    console.log(num);
    up_num.text(data[i].positive_count);
    down_num.text(data[i].negative_count);
  };
}
