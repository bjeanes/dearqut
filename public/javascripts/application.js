$(function() {
  $('#message_body').focus();
  
  if($('input#message_tag_list').length > 0)
  {
    var tags = new TextboxList('#message_tag_list', {
      plugins: {
        autocomplete: {}
      },
      bitsOptions: {
        editable: {
          addKeys: [32, 188],
          addOnBlur: true
        }
      },
      unique: true,
    });
    tags.getContainer().addClass('textboxlist-loading');
    $.ajax({
      url: '/tags',
      dataType: 'json',
      success: function (r) {
        tags.plugins['autocomplete'].setValues(r);
        tags.getContainer().removeClass('textboxlist-loading');      
      }
    });
    $('.controls form').submit(vote);
  }
});

function vote() {
  var form = $(this);
  $.post(form.attr('action'), {}, voteCallback, 'json');
  return false;
}

function voteCallback(data) {
  for (var i = data.length - 1; i >= 0; i--){
		var v = data[i];
		var c = $('#controls-' + v.id);
	
		if(v.success) {
			$('a', c).click = null;
			
			var agree    = $('.agree',   c);
	    var disagree = $('.disagree', c);
	
			$('.num',    agree).text(v.positive_count);
	    $('.num', disagree).text(v.negative_count);
	
	    var agree_img    = $('img', agree);
	    var disagree_img = $('img', disagree);
	
			if(data[i].value < 0) {
				disagree_img.attr("src", "/images/youdisagreed.png");
        agree_img.attr("src", "/images/agree.png");
			} else {
        agree_img.attr("src", "/images/youagreed.png");
        disagree_img.attr("src", "/images/disagree.png");
			}
		} else {
			// not logged in or already voted
		}
  };
}
