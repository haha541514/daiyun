//�������
var ispassvalid = false;
var isupdate = false;
var isphone = false;
//���ȷ������
var ispass1valid = false;
function sendPhoneCode(phone) {
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
		$.ajax( {
					type:"post",
					url : basePath+'/util/sendMobileValidateCode',
					async: false,
					data : {"tel" : phone},
					success:function(msg){
						if(msg == "�����ʽ����"){
							ShowWrong($("#r_tel"), "�����ʽ����", "error");
						}else {
							$('#r_but').css({color:'#F3F3F3',background:'#9F9E9D'});				
							$("#r_code").attr("disabled",false);//��������
							updateTimeLabel(60,"0");
							
						}			
												
					}
						
				});
}


/**�޸�ʱ��lable*/
function updateTimeLabel(time, message) {
	//var btn = jQuery("#r_code");//setInterval javaScript����
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
function sendMsg() {
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	if($("#r_phone").val() == ""){
		 ShowWrong($("#r_phone"), "�������ֻ���", "plus_c");
	     return false;
	}
	$.ajax( {
		type:"post",
		url : basePath+'/util/sendMobileValidateCodebyName',
		async: false,
		data : {"tel" : $("#r_phone").val()},
		success:function(msg){
			if(msg == "false"){
				ShowWrong($("#r_phone"), "�Ҳ�������", "plus_c");
			}else {
				sendPhoneCode($("#r_phone").val());
				$('#r_but').css({color:'#F3F3F3',background:'#9F9E9D'});	
				
				$("#r_code").attr("disabled",false);//��������
				updateTimeLabel(60,"0");
				
			}			
									
		
		}
			
	});
}
//��֤�뷢��
/*function sendMsg() {
	var location = (window.location+'').split('/');
	var basePath = location[0]+'//'+location[2]+'/'+location[3];
	if($("#r_username").val() == ""){
		 ShowWrong($("#r_username"), "�������û���", "plus_c");
	     return false;
	}
	$.ajax( {
		type : "post",
		url : basePath+"/util/sendMobileValidateCodebyName",
		async: false,
		//contentType : "application/x-www-form-urlencoded;charset=utf-8",
		data : {
		r_usename : $("#r_username").val()
		},
		success : function(msg) {
			if(msg == "false" ){
			  ShowWrong($("#r_username"), "�û�������", "plus_c");
			}else{
				sendPhoneCode(msg);
			}	
		},
		error: function (XMLHttpRequest,textStatus,errorThrown) {
  		  	console.log(XMLHttpRequest.responseText);
  			console.log(XMLHttpRequest.status);
  			console.log(XMLHttpRequest.readyState);
  			console.log(textStatus);
  			istruecode = false;
  		}
	});
}*/

function ShowWrong(obj, message, className) {
    var showObject = jQuery("#div_" + jQuery(obj).attr("id"));
    showObject.show();
    showObject.html("<div class=\"" + className + "\">" + message + "</div>");
    //jQuery("#div_mathcode").hide();
};
var isNextPage = false;
function check_vadatelicode(){
		var r_butValue = $('#r_code').val();
		if(r_butValue == ''){
			//ShowWrong($("#r_code"), "", "plus_c");
			alert('��������֤��');
		}else{//У����֤��
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			$.ajax( {
				type:"post",
				url : basePath+'/util/checkMobileValiteCodeEx',
				async: false,
				data : {"mobileValidateCode" : $('#r_code').val()},
				success:function(msg){
					if(msg == "false"){
						ShowWrong($("#r_but"), "��֤�����", "plus_c");
					}else {
						isNextPage = true;
						ShowWrong($("#r_but"), "", "pw_success");				
							
					}			
											
				}
					
			});
		}
		
}		

jQuery(document).ready(function () {
    /*jQuery("#r_username").val(""); 
   
    jQuery("#r_username").focus(function() {
        ShowWrong(jQuery("#r_username"), "�������û���", "plus_b");
    });
    jQuery("#r_username").blur(function() {
       //check_username(this);
    	check_username();
    });
  /*  jQuery("#r_code").blur(function() {      
        check_vadatelicode(this);     
    });*/
    
    jQuery("#r_phone").focus(function() {
        ShowWrong(jQuery("#r_phone"), "�������ֻ���", "plus_b");
    });
    jQuery("#r_phone").blur(function() {
    	check_phone(this);
    });
    
    
    jQuery("#r_newpass").focus(function() {
        ShowWrong(jQuery("#r_phone"), "����������", "plus_b");
    });
    jQuery("#r_newpass").blur(function() {
    	check_newPass(this);
    });
    
    jQuery("#r_confirmpass").focus(function() {
        ShowWrong(jQuery("#r_confirmpass"), "������ȷ������", "plus_b");
    });
    jQuery("#r_confirmpass").blur(function() {
    	check_confirmpass(this);
    });
    
});
function check_phone(obj){
	var length = GetStrLen(val(obj));
	if(length == 0 || length!=13){
		ShowWrong($('#r_phone'), "�ֻ��Ų���ȷ", "plus_c");
	}
	var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
	if(mobile.test(val(obj))){
		isphone = true;
		ShowWrong($('#r_phone'), "", "pw_success");
	}else{
		
		ShowWrong($('#r_phone'), "�ֻ��Ŵ���", "plus_c");
	}
	
	
}
//��ͨ��֤
function check_username() {
    if ($('#r_username').val() == "") {
        ShowWrong($('#r_username'), "�û���Ϊ��", "plus_c");
    }else{
    	 ShowWrong($('#r_username'), "", "pw_success");
    }
}    

//�������
function check_newPass(obj){
	if (isupdate) {
        ispassvalid = true;
        ShowWrong(obj, "", "");
    }
    else {
        if (val(obj) == "") {
            ShowWrong(obj, "����������", "plus_c");
            //ShowWrong(obj, "", "");
            ispassvalid = false;
            return false;
        }
        if ((/>|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|`/i).test(val(obj))) {
            ShowWrong(obj, "�����������ַ�", "plus_c");
            ispassvalid = false;
            return false;
        }
        if (val(obj).indexOf(" ") > -1) {
            ShowWrong(obj, "�벻Ҫ����ո�", "plus_c");
            ispassvalid = false;
            return false;
        }
        if (GetStrLen(val(obj)) < 6 || GetStrLen(val(obj)) > 16) {
            ShowWrong(obj, "����Ҫ��6-16���ַ�", "plus_c");
            ispassvalid = false;
            return false;
        }
        if (jQuery.trim(jQuery("#r_confirmpass").val()) != "") {
            if (val(obj) != jQuery.trim(jQuery("#r_confirmpass").val())) {
                ShowWrong(jQuery("#r_confirmpass"), "������������벻һ��", "plus_c");
                ispassvalid = false;
                return false;
            }
        /*    else {
                isupdate = true;
                ShowWrong(jQuery("#r_confirmpass"), "", "pw_success");
            }*/
        }
        ispassvalid = true;
        ShowWrong($('#r_newpass'), "", "pw_success");
        //showpass(obj);
    }
}
//ȷ������
function check_confirmpass(obj){
	if (val(obj) == "") {
        ShowWrong(obj, "����������", "plus_c");
        ispass1valid = false;
        return false;
    }
    if ((/>|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|`/i).test(val(obj))) {
        ShowWrong(obj, "�����������ַ�", "plus_c"); ;
        ispass1valid = false;
        return false;
    }

    if (GetStrLen(val(obj)) < 6 || GetStrLen(val(obj)) > 16) {
        ShowWrong(obj, "����Ҫ��6-16���ַ�", "plus_c"); ;
        ispass1valid = false;
        return false;
    }

    if (val(obj) != jQuery.trim(jQuery("#r_newpass").val())) {
        ShowWrong(obj, "������������벻һ��", "plus_c");
        ispass1valid = false;
        return false;
    }
    ispass1valid = true;
    ShowWrong(obj, "", "pw_success");
}
function GotoNextPage(){//У����֤��
	check_vadatelicode();
	
	if(isNextPage){
		$('#password1').hide();
		$('#password2').show();
	}
}
//����ַ�������
function GetStrLen(key) {
    var l = escape(key), len;
    len = l.length - (l.length - l.replace(/\%u/g, "u").length) * 4;
    l = l.replace(/\%u/g, "uu");
    len = len - (l.length - l.replace(/\%/g, "").length) * 2;
    return len;
}
//�õ�����ֵ���ѹ��˿ո�
function val(obj) {
    return jQuery.trim(jQuery(obj).val());
}

//��ʾ����ǿ��
function showpass(obj) {

    var item = val(obj);
    if (item != '' && (item.match(/^[0-9]{1,16}$/) || item.match(/^[A-Za-z]{1,16}$/) || item.match(/^[_]{1,16}$/))) {
        showitem = "<div class=\"pw_weight\" id=\"red_password_weight\"><span class=\"w1\" ></span></div>";
    }
    else if (item != '' && (item.match(/^[a-z0-9]{1,16}$/) || item.match(/^[A-Za-z]{1,16}$/) || item.match(/^[0-9_]{1,16}$/))) {
        showitem = "<div class=\"pw_weight\" id=\"red_password_weight\"><span class=\"w2\" ></span></div>";
    }
    else if (item != '' && item.match(/^[A-Za-z0-9]{1,16}$/)) {
        showitem = "<div class=\"pw_weight\" id=\"red_password_weight\"><span class=\"w3\" ></span></div>";
    }
    else {
        showitem = "";
    }
    var showObject = jQuery("#div_" + jQuery(obj).attr("id"));
    ShowWrong(obj, "", "pw_success");

    if (!isupdate) {
        showObject.html(showObject.html() + "" + showitem);
    }

}

