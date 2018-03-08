$(document).ready(function(){
	$("#u_list li a").click(function(){
		 $(this).css("color","#FFF");
		 $(this).css("background","url(/daiyun/order_images/order_bg.png)");
		 var divid= "m"+$(this).attr("id").substring(1,2);
		 $(".matter").each(function(){
			 if($(this).attr("id")==divid){
			 $(this).show();
			 }
			 else{
				 $(this).hide();
			 }
		 });
		 $(".goods").each(function(){
			 if($(this).attr("id")==divid){
			 $(this).show(); 
			 }
			 else{
				 $(this).hide();
			 }
		 });
		 $(this).parent().siblings().each(function(){
			 $(this).children().css("color","#333");
			 $(this).children().css("background","url(/daiyun/order_images/order_bg01.png)");	 
		 })		 		
		});
});


