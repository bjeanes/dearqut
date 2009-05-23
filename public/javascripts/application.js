$(function() {
  $('.controls .agree a').click(agree);
  $('.controls .disagree a').click(disagree);
});

function agree() {
  vote(this, 'up');
}

function disagree() {
  vote(this, 'down');
}

function getMessageId(vote) {
  id = $(vote).parent().parent()[0].id;
  return (+id.split('-')[1]);
}
  

function vote(message, direction) {
  if (typeof value != 'number')
    message = getMessageId(message);
  
  var url = "/messages/" + message.toString() + "/vote/" + direction;
  
  $.post(url, {}, function(data) {
    console.log(data.toString());
  }, 'text');
}