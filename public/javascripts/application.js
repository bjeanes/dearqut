$(function() {
  var tagInput = $("input.autobox.tags");
  
  if(tagInput.length != 0) {
    var preVals = tagInput.attr("value").toString().replace(/^\s+|\s+$/,'').split(/\s+/);

    if(preVals.length == 1 && preVals[0] == "")
      preVals = [];

    tagInput.autobox({
      ajax: "/tags",
      match: function(typed) {
        this.typed = typed;
        this.pre_match = this.name;
        this.match = this.post_match = '';
        if (!this.ajax && !typed || typed.length == 0) { return true; }
        var match_at = this.name.search(new RegExp("\\b" + typed, "i"));
        if (match_at != -1) {
          this.pre_match = this.name.slice(0,match_at);
          this.match = this.name.slice(match_at,match_at + typed.length);
          this.post_match = this.name.slice(match_at + typed.length);
          return true;
        }
        return false;
      },
      insertText: function(obj) { return obj.name; },
      templateText: "<li><%= pre_match %><u><%= match %><u><%= post_match %> (<%= taggings_count %>)</li>",
      prevals: preVals
    });

    $('ul.autobox-hldr').click(function() { 
      $('li.autobox-input input', this).focus(); 
    });
    
    $("input.autobox")
      .bind("activate.autobox", function(e, d) { console.log(d); })
      .bind("cancel.autobox", function(e) { console.log("Cancelled"); });
  }

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
		var v = data[i];
	
		if(v.success) {
			var up = $('#controls-' + v.id + ' .up');
	    var down = $('#controls-' + v.id + ' .down');
	
			$('.num',   up).text(v.positive_count);
	    $('.num', down).text(v.negative_count);
	
			if(data[i].value < 0) {
				$('img', down).attr("src", "/images/youdisagreed.png");
			} else {
				$('img',   up).attr("src", "/images/youagreed.png");
			}
		} else {
			alert("Are you sure you are logged in?");
		}
  };
}
