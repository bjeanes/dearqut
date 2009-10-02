jQuery.noConflict();


jQuery(document).ready(function(){	 
	kriesi_tab('#content','.jquery_tab_title','.jquery_tab'); /*remove this if you dont want to have jquery tabs*/
	kriesi_navigation(".nav"); /*remove this if you dont want a jquery sidebar menu*/
	kriesi_closeable_divs(".closeable"); /*remove this if you dont want message box to be closeable*/
	jQuery(".flexy_datepicker, .flexy_datepicker_input").datepicker(); //datepicker input field and box
	jQuery("#dialog").dialog(); //pop up dialog window on pageopen.
	jQuery('.richtext').wysiwyg(); //rich text editor for textareas
	choosetab();
	});



function kriesi_closeable_divs(element)
{
	jQuery(element).each(function()							  
	{
		jQuery(this).append('<div class="click_to_close"></div>')
	});	
	
	jQuery(".click_to_close").click(function()
	{
		jQuery(this).parent().slideUp(200);	
	});
}



function kriesi_navigation(element)
{
	jQuery(element).each(function()
	{	
		var currentlistitem;
		currentlistitem = jQuery(this).find(">li");
		
		currentlistitem.each(function()
		{	
			if (!jQuery(this).find('ul').hasClass('opened')){
			jQuery(this).find('ul').addClass("closed").css({display:"none"});
			}
		});
		
		currentlistitem.find('a:eq(0)').each(function()
		{
			jQuery(this).click(function()
			{	
				if(jQuery(this).next('ul').hasClass('closed')){
				jQuery(this).next('ul').slideDown(200).removeClass("closed");
				return false;
				}else{
				jQuery(this).next('ul').slideUp(200).addClass("closed");	
				return false;
				}
			});	
		});
	});
}



function kriesi_tab(wrapper, header, content){
	var title = wrapper + " " + header;
	var container_to_hide = wrapper + " " + content;
	var duration = 200;
	
	if (jQuery.browser.msie){
		  duration = 10;
		  }
	disable = false;
	

jQuery(title).each(
					  function(i){
						 if (i == 0){
						jQuery(wrapper).prepend("<div class='jquery_tab_container'><a href='/' class='heading_tab advanced_link active tab"+(i+1)+"'>"+jQuery(this).html()+"</a></div>");
							}else{
						jQuery(".advanced_link:last").after("<a href='/'class='heading_tab advanced_link tab"+(i+1)+"'>"+jQuery(this).html()+"</a>");
							}
						 }
					  );

jQuery(container_to_hide).each(
						 function(i){
						jQuery(this).addClass("tablist list_"+i); 
							if(i != 0){
								jQuery(this).css({display: "none"});
							}
						  }
					 );

jQuery(".advanced_link").each(
					  function(i){
						jQuery( this ).bind ("click",function(){
												if(jQuery(this).hasClass('active')){return false}
														 if(disable == false){disable = true;
														 jQuery(".advanced_link").removeClass("active");
														 jQuery(this).addClass("active");
														 
														 jQuery(container_to_hide+":visible").fadeOut(duration,function(){
																	
																	jQuery(".list_"+i).fadeIn(duration, function(){disable=false; });
																								   });
														 }
														 return false;

														 });
						  }
					  );
}

function choosetab()
{
	var hash = window.location.hash;
	if(hash.match(/^#tab(\d)$/))
	{
		var tab = hash.replace(/^#tab/,"");
		var select_tab = tab-1;
		jQuery(".jquery_tab").css({display:"none"}).filter(":eq("+select_tab+")").css({display:"block"});
		jQuery(".jquery_tab_container .active").removeClass('active');
		jQuery(".heading_tab").filter(":eq("+select_tab+")").addClass('active');
		
	}
}
