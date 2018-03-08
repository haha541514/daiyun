(function($) {
	$.fn.featureList = function(options) {
		var tabs	= $(this);
		var output	= $(options.output);

		new jQuery.featureList(tabs, output, options);

		return this;	
	};

	$.featureList = function(tabs, output, options) {
		function slide(nr) {
			if (typeof nr == "undefined") {
				nr = visible_item + 1;
				nr = nr >= total_items ? 0 : nr;
			}

			tabs.removeClass('this').filter(":eq(" + nr + ")").addClass('this');

			output.stop(true, true).filter(":visible").fadeOut();
			output.filter(":eq(" + nr + ")").fadeIn(function() {
				visible_item = nr;	
			});
		}

		var options			= options || {}; 
		var total_items		= tabs.length;
		var visible_item	= options.start_item || 0;

		options.pause_on_hover		= options.pause_on_hover		|| true;
		options.transition_interval	= options.transition_interval	|| 5000;

		output.hide().eq( visible_item ).show();
		tabs.eq( visible_item ).addClass('this');

		tabs.hover(function() {
			if ($(this).hasClass('this')) {
				return false;	
			}

			slide( tabs.index( this) );
		});

		if (options.transition_interval > 0) {
			var timer = setInterval(function () {
				slide();
			}, options.transition_interval);

			if (options.pause_on_hover) {
				tabs.mouseenter(function() {
					clearInterval( timer );

				}).mouseleave(function() {
					clearInterval( timer );
					timer = setInterval(function () {
						slide();
					}, options.transition_interval);
				});
			}
		}
	};
})(jQuery);
 $(document).ready(function() {
		$('.banner .nav_banner li').featureList({
    output: '.banner .nav_img  li',
        start_item: 0
    });
	$('.works_box .works_banner li').featureList({
    output: '.works_box .works_img  li',
        start_item: 0
    });
	$('.slide .slide_banner li').featureList({
    output: '.slide .slide_img  li',
        start_item: 0
    });
	$('.culture_box .culture_banner li').featureList({
    output: '.culture_box .culture_img  li',
        start_item: 0
    });
	$('.amoy_box .amoy_banner li').featureList({
    output: '.amoy_box .amoy_img  li',
        start_item: 0
    });
		
    }); 
//顶部导航栏颜色初始化
 function changeTopmenu(index,length){
	 if(index!="0"){
	 $("#menu_ul li:eq(0)").removeClass().addClass("hover");
	 }
	 $("#menu_ul li:eq("+index+")").css("background-color","#d42c96");
	 $('html,body').animate({scrollTop:length+'px'},100);
	 }
 
 //查询界面左侧列表颜色变化
 $(document).ready(function(){$("#left_menu li").click(function(){
	 $("#left_menu li").css("background-color","white");
	 $(this).css("background-color","d3eef9");
	 }
	 );
 });
  //首页右侧微星QQ,微信联系框
 $(document).ready(function(){
	 $("#close_chat").click(function(){
		 $("#chat_f1").hide();
		 $("#chat_f2").css("display","block");
	 });
 });
 
 $(document).ready(function(){
	 $("#chat_f2").click(function(){
		 $("#chat_f1").show();
		 $("#chat_f2").hide();
		 
	 });
 });
 

          
 
