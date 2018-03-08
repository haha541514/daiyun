$(document).ready(function(){
	$("#guide div").click(function(a){
	var index=$(this).attr("class").split(" ")[0];
	$("#"+index+" li").slideToggle("slow");
	return false;
	});
	}
);

$(document).ready(function(){
	$("#hj_op a:eq(1)").click(function(){
		$(this).parent().parent().remove();
	});
});

$(document).ready(function(){
	$("#hj_edit").click(function(){
		if($("#hj_edit").html()=='保存'){
		$(this).parent().siblings().children("input").attr("readonly","readonly");
		$("#hj_edit").html("修改");
		}
		else{
		$(this).parent().siblings().children("input").removeAttr("readonly").focus().css("border","1px");
		$("#hj_edit").html("保存");
		}
	});
});

$(document).ready(function(){
	$("#hw_edit").click(function(){
		if($("#hw_edit").html()=='保存'){
		$(this).parent().siblings().children("input").attr("readonly","readonly");
		$("#hw_edit").html("修改");
		}
		else{
		$(this).parent().siblings().children("input").removeAttr("readonly").focus().css("border","1px");
		$("#hw_edit").html("保存");
		}
	});
	
});
$(document).ready(function(){
	$("#hw_op a:eq(1)").click(function(){
		$(this).parent().parent().remove();
	});
});

$(document).ready(function(){
	$("#selType input").click(function(){
		var arr=["3","5","7","8"];
		if(-1!=$.inArray($(this).val(),arr)){
			$("#battery option").show();
		}
		else{
			$("#battery option").hide();
			$("#battery option:eq(0)").attr("selected","selected");
		}
	})
});
	

	



          
 
