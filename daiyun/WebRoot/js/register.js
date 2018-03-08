/*************2016-12-07,Start by wukq******************/

var ismobilevalid = false;

//�ֻ���֤��
function getPhoneCode() {
	if ($("#r_but").html() == "��ȡ������֤��") {
		$("#r_code").val("");
	}
	if ($("#r_tel").val() == "") {
		//����ֻ����Ƿ�Ϊ��
		ShowWrong($("#r_tel"), "�������ֻ�����", "error");
		ismobilevalid = false;
		return false;
	}
	check_mobilebase();
	if(ismobilevalid){
		setTimeout(check_mobileIsUserd(),1000);
	}
		
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	if (ismobilevalid) {
		$.ajax( {
					type:"post",
					url : basePath+'/util/sendMobileValidateCode',
					async: false,
					data : {"tel" : $("#r_tel").val()},
					success:function(msg){
						if(msg == "�����ʽ����"){
							
							ShowWrong($("#r_tel"), "�����ʽ����", "error");
						}else {
							$('#r_but').css({color:'#F3F3F3',background:'#9F9E9D'});	
							//ShowCorrect($("#r_tel"), "���ͳɹ�", "error");
							$("#r_code").attr("disabled",false);//��������
							updateTimeLabel(60,"0");
							//$('#r_but').css({color:'#FDFDFD',background:'#01B0EE'});
						}			
												
					
					}
						
				});
				
	}
	return false;
}

//�ֻ��������ʽ���
function check_mobilebase() {

	var mobile = $.trim($("#r_tel").val());
	//var pat = /^1\d{10}$/;
	var pat = /(^1[3|4|5|6|7|8|9]\d{9}$)/;
	if (mobile == "") {
		ShowWrong($("#r_tel"), "�������ֻ�����", "plus_c");
		ismobilevalid = false;
		return false;
	}
	if (!pat.test(mobile)) {
		ShowWrong($("#r_tel"), "�ֻ������ʽ����ȷ", "plus_c");
		ismobilevalid = false;
		return false;
	}
	var showObject = $("#div_strMobile");
	ismobilevalid = true;
}


/**����ֻ��Ƿ��ù�**/
function check_mobileIsUserd(){
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	$.ajax( {
		type:"post",
		url : basePath+'/checkPhone',
		async: false,
		data : {"r_tel" : $("#r_tel").val()},
		success:function(msg){
			if(msg == "false"){
				ismobilevalid = false;
				ShowWrong($("#r_tel"), "�ֻ����ظ�", "error");
			}else {
				ismobilevalid = true;
			}			
									
		
		}
			
	});
}

/**�޸�ʱ��lable*/
function updateTimeLabel(time, message) {
	var btn = jQuery("#r_code");//setInterval javaScript����
	var hander = setInterval(function() {
		if (time == 0) {
			clearInterval(hander);
			hander = null;
			$("#r_but").attr("disabled",false);
			$("#r_but").html("��ȡ������֤��");
			$('#r_but').css({color:'#FDFDFD',background:'#01B0EE'});
		} else {
			$("#r_but").attr("disabled",true);
			var times = "" + (time--) + "��������·���";
			$("#r_but").html(times);
			
		}
	}, 1000);
}

//��֤�뷢��
function sendMsg() {
	$("#obtain").html("��֤�뷢����");
	$.ajax( {
		type : "post",
		url : "util/sendMobileValidateCode",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		data : {
			tel : $("#number_01").val()
		},
		success : function(data) {
			$("#obtain").html(data);
			setTimeout("$('#obtain').html('û�յ�?,�������·��͡�')", 30000);
		}
	});
}
//��֤��У��
function checkVlidateCode() {
	var bool = true;
	if ($("#validateCode").val() == "") {
		return false;
	}
	$.ajax( {
		type : "Post",
		url : "util/checkMobileValiteCode",
		async : false,
		data : {
			mobileValidateCode : $("#validateCode").val()
		},
		success : function(data) {
			if (data == 'N') {
				bool = false;
			}
		}
	});
	return bool;
}
function ShowCorrect(obj, message, className){
	 var ErrorObject = $("#"+$(obj).attr("id")+"-error");
	 ErrorObject.css("display","inline");
	 ErrorObject.html(message); 
}

 function ShowWrong(obj, message, className){
	  //��д�����������jqueryValidate���ɵ�label,background: url('images/m_no.png')
	 //<label id="r_code-error" class="error" for="r_code" style="display: inline;">�������û���</label>
	 var ErrorObject = $("#"+$(obj).attr("id")+"-error");
	 ErrorObject.css("display","inline");
	 //ErrorObject.attr("background","url('${pageContext.request.contextPath}/images/m_no.png')");
	 ErrorObject.html(message); 
}
 //ShowWrong(jQuery("#strMobile"), "�������ֻ�����", "plus_c");
 function ShowWrong(obj, message, className) {
	    var showObject = jQuery("#div_" + jQuery(obj).attr("id"));
	    showObject.show();
	    showObject.html("<div class=\"" + className + "\">" + message + "</div>");
	    jQuery("#div_mathcode").hide();

	}
/**************2016-12-07,End********************/
