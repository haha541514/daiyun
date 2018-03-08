$(document).ready(function(){
	$("#u_list li a").click(function(){
		 $(this).css("color","#FFF");
		 $(this).css("background","url(/daiyun/order_images/order_bg.png)");
		 var divid= "m"+$(this).attr("id").substring(1,2);
		 if($(this).attr("id").substring(1,2)=="1"){
			 $("#indexShow1").show();
			 $("#scScshipperconsigneetype").val("S");
			 $("#indexShow2").hide();
			 $("#indexShow3").hide();
		 }
		 if($(this).attr("id").substring(1,2)=="2"){
			 $("#indexShow1").hide();
			 $("#indexShow3").hide();
			 $("#scScshipperconsigneetype").val("C");
			 $("#indexShow2").show();
		 }
		 if($(this).attr("id").substring(1,2)=="3"){
			 $("#indexShow1").hide();
			 $("#indexShow2").hide();
			 $("#scScshipperconsigneetype").val("T");
			 $("#indexShow3").show();
		 } 
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
	$("#re_button").click(function(){
		$('#scsccode').attr("value","");
		$('#text00').attr("value","");
		$("#text01").attr("value","");
		$("#text02").attr("value","");
		$("#text1").attr("value","");
		$("#text2").attr("value","");
		$("#text3").attr("value","");
		$("#text4").attr("value","");
		$("#text5").attr("value","");
		$("#text6").attr("value","");
		$("#text7").attr("value","");	
	});
});




