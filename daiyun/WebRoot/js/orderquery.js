

	var URL = window.location.href;

	//ˢ��
	var doReset = function(){
		mysearch();
	}
	
	//��������
	function mydetail(){
		if(chooseOneOnly()){
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			var url = basePath+"/order/queryOrdersDetail?cw_code=" +document.getElementById("cwcode").value ;
			window.open(url);
		}
	}
	//ɾ��
	 function mydelete(){
			if(chooseOneAtLeast()){
				if(confirm("�Ƿ�ɾ��?ɾ���������Ҫ�ָ����뵽'��������վ'���в�����")){
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					
					document.getElementById("myform").action=basePath+"/order/deleteTransientOrders";
					document.getElementById("myform").submit();
				}			
			}
		}
	//����,���걨����Ϊ�ݴ�
	function myrecover(){
		if(chooseOneAtLeast()){
			if(confirm("ȷ�ϳ���")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/newRecoverDeclaredOrders";	
				document.getElementById("myform").submit();
			}
		}
	}
	//�Ѵ�ӡ����Ϊ����
	function printRecover(){
		if(chooseOneAtLeast()){
			if(confirm("ȷ�ϳ���")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/newRecoverOrders";
				document.getElementById("myform").submit();
				alert("�����ɹ�");
			}
		}
	}
	//�ظ���ӡ
	function myprint(){
		if(chooseOneAtLeast()){	
			$(".button3").append($("#print_format"));//�������
			document.getElementById("xian").style.display="";
			document.getElementById("defaultCheck").checked=true;
		}
	}	
	//��ӡ��Ʊ
	function billPrint(){
		if(chooseOneAtLeast()){	
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			document.getElementById("myform").action=basePath+"/order/queryPrinterBill";
			//document.getElementById("myform").action="${pageContext.request.contextPath }/order/queryPrinterBill";
			document.getElementById("myform").target="_blank";
			document.getElementById("myform").submit();
			//var url="${pageContext.request.contextPath }/order/queryPrinterBill?cw_code=" +document.getElementById("cwcode").value;		
			//window.open(url);
		}
	}
	//�ۼ�,�ж����ջ���״̬��,���ջ�״̬��SO״̬���������
	function detain(){
		if(chooseOneAtLeast()){
			if(checkDetain()){
				if(AgreeAllocation()){
					if(confirm("ȷ����Ϊ�ۼ�")){
						var location = (window.location+'').split('/');
						var basePath = location[0]+'//'+location[2]+'/'+location[3];
						document.getElementById("myform").action=basePath+"/order/detainOrders";
	
						//document.getElementById("myform").action="${pageContext.request.contextPath }/order/detainOrders";
						document.getElementById("myform").submit();
						alert("�ۼ��ɹ�");
					}
				}	
			}
		}
	}
	//���
	function myallocate() {
		if(chooseOneAtLeast()) {
			if(confirm("ȷ�����")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/allocate";

				//document.getElementById("myform").action="${pageContext.request.contextPath }/order/allocate";
				document.getElementById("myform").submit();
			}
		}	
	}
	//������
	function completeAllocate(){
		if(chooseOneAtLeast()){
				if(confirm("ȷ����������")){
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/completeAllocate";
					
					//document.getElementById("myform").action="${pageContext.request.contextPath }/order/completeAllocate";
					document.getElementById("myform").submit();
					alert("������ɹ�");
				}
		}
	}
	//ȷ�����
	function checkDetain(){
		var count=0;
		var checkbox1 = document.getElementsByName("checkbox1");
		for(var i = 0;i<checkbox1.length;i++){
			if(checkbox1[i].value=="ȷ���ۼ�"&& checkbox1[i].checked==true){
				count++;
			}
		}
		if(count>0)	{
			alert('��ѡ��ۼ�״̬����"ȷ���ۼ�"�ļ�¼');
			return false;
		}else{
			return true;
		}
	}
	//�������,��ȡtableѡ���е�cws_name���ж�,����ǳ�����������ۼ�
	function AgreeAllocation(){
		var table = document.getElementById("attributeval");
		var checkbox = $('input[name="checkbox"]');
		for(var index = 0 ; index < checkbox.length ; index++ ){
			if(checkbox[index].checked == true){
				var strCwsname = table.rows[index+1].cells[9].innerHTML;//��ȡ�˵�״̬���Ѵ�ӡ���Ƶ�����������ۼ�
				if(strCwsname == '�Ѵ�ӡ' || strCwsname == '�Ƶ�' || strCwsname == '����'){
					
					return true;
				}else{
					alert("�ѳ���,���ܿۼ�");
					return false;
				}
			}
		}
	}
	
	
	
	// ɾ��
	var mydelete =  function(){
		if(chooseOneAtLeast()){
			if(confirm("�Ƿ�ɾ��?ɾ���������Ҫ�ָ����뵽'��������վ'���в�����")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/deleteTransientOrders";
				//document.getElementById("myform").action='${pageContext.request.contextPath }/order/deleteTransientOrders';
				document.getElementById("myform").submit();
			}			
		}
	}
	// �걨
	function mydeclare(){
		if(chooseOneAtLeast()){
			if(confirm("ȷ���걨")){	
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/declare";
					//document.getElementById("myform").action="${pageContext.request.contextPath }/order/declare";
					document.getElementById("myform").submit();
			}
		}
	}
	// �걨�����
	function mycomplete(){
		if(chooseOneAtLeast()){
			if(confirm("�Ƿ��걨����ɣ�")){
					Ext.MessageBox.wait("�걨��...", "���Ժ�");
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/declareandcomplete";
					//document.getElementById("myform").action='${pageContext.request.contextPath }/order/declareandcomplete';
					document.getElementById("myform").submit();	
			}		
		}
	}
	/* ��������ɾ�� */
	function deleteBatch(){
		var customerewbcode = document.getElementById("customerewbcode").value.replace(/^\s+|\s+$/g,"");
		var strHwconsigneename = document.getElementById("strHwconsigneename").value.replace(/^\s+|\s+$/g,"");
		var pkCode = document.getElementById("pkCode").value.replace(/^\s+|\s+$/g,"");
		var strHwConsigneeCompany = document.getElementById("strHwConsigneeCompany").value.replace(/^\s+|\s+$/g,"");
		var startdate = document.getElementById("startdate").value;
		var enddate = document.getElementById("enddate").value;
		var buyerid = document.getElementById("buyerid").value.replace(/^\s+|\s+$/g,"");
		var transactionid = document.getElementById("transactionid").value.replace(/^\s+|\s+$/g,"");
		if((customerewbcode==""||customerewbcode==null)&&
				(strHwconsigneename==""||strHwconsigneename==null)&&
				(pkCode==""||pkCode==null)&&
				(strHwConsigneeCompany==""||strHwConsigneeCompany==null)&&
				(startdate==""||startdate==null)&&
				(enddate==""||enddate==null)&&
				(buyerid==""||buyerid==null)&&
				(transactionid==""||transactionid==null)){
			alert("����������һ������!");
			return;
		}else{
			if(confirm("ȷ��Ҫ����ɾ����?")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+'/order/deleteTransientOrders?customerewbcode='+customerewbcode+
				'&strHwconsigneename='+strHwconsigneename+'&pkCode='+pkCode+'&strHwConsigneeCompany='+strHwConsigneeCompany+'&=startdate'+startdate+
				'&enddate='+enddate+'&=buyerid'+buyerid+'&=transactionid'+transactionid;
				document.getElementById("myform").submit();
			}
		}
	}
	// �޸Ļ�����Ϣ
	//�޸Ļ�����Ϣ
	function updateProIf(){
		if(chooseOneAtLeast()){
			//${pageContext.request.contextPath }/order/queryModifyOrders?cw_code=<s:property value='#bean.Cwcw_code'/>&link=printed"
			//var url="${pageContext.request.contextPath }/order/queryModifyOrders?cw_code=" +document.getElementById("cwcode").value+"&link=printed";
			//window.open(url);
			var code=document.getElementById("cwcode").value;
			code=code.split(",");
			if(code.length<1){
				return;
			}			
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			//document.getElementById("myform").action=basePath+"queryModifyOrders?cw_code="+code[0]+"&link=printe";
			document.getElementById("myform").action=basePath+"/queryOrdersDetail?cw_code="+code[0]+"&link=received";
			document.getElementById("myform").target="";
			document.getElementById("myform").submit();
		}
	}
	
  //���ظ�ѡ��ѡ�и���
    function check(){
       var count = 0;    
       var checkBox = document.getElementsByName("checkbox");
       for(var i = 0;i<checkBox.length;i++){
          if(checkBox[i].checked == true){
              count++;
          }
       }     
       return count;
    }
  //���ظ�ѡ��ѡ�еĶ����� 
      function checkvalue(){
       var str = "";    
       var checkBox = document.getElementsByName("checkbox");
       //var strPkcode = document.getElementsByName("pkCode");
       for(var i = 0;i<checkBox.length;i++){
          if(checkBox[i].checked == true){
             // str = str + "["+ strPkcode[i+1].value+"],";
              str = str + "["+ checkBox[i+1].value+"],";
          }
       }  
       return str;
    }
    
  //�ж�ѡ�еĻ������������ƣ���ַ���Ƿ���ȫ��ͬ
   function pandu(){
  	   var chname = document.getElementsByName("checkbox");
  	   var tab = document.getElementById("attributeval");
  	   var count = 0;
  	   var array = new Array();
  	   var strcw ="";
  	   for(var i = 0;i<chname.length;i++){
  	      if(chname[i].checked == true){		//���������ݷֱ𸳸�����
  	          var rowle = chname[i].parentElement.parentElement.rowIndex;//row = 9 
  	          strcw = tab.rows[rowle].cells[5].innerHTML+tab.rows[rowle].cells[7].innerHTML+tab.rows[rowle].cells[7].innerHTML;
  	  		  array[count] = strcw;
  	          count++;
  	      }
  	   }
  	   var flag = "";
  	   for(var k = 0;k<count-1;k++){	//���������жϣ��ж����������Ƿ����ͬ
  		   if( (array[k] == array[k+1])){
  			      flag = true;
  			   }
  			   else{ 
  			      flag = false;
  			      break;
  			   }
  	   }
  	   return flag;
  	}

  	 //���
    function doPack(str){
       var count = check();
       var str1 = checkvalue();
       var location = (window.location+'').split('/');
       var basePath = location[0]+'//'+location[2]+'/'+location[3];
		
       str1 = str1.substring(0,str1.length-1);
       if(count == 0){
          if(str=="add" || str =="all"){
             alert("��ѡ�����������д��");
             return false;
          }
          if(str=="remove" || str =="all"){
             alert("��ѡ��һ���������в��");
             return false;
          }
       }
       if(count == 1){
          if(str=="add"){
             alert("��ѡ�����������д��");
             return false;
          }
          if(str=="remove" || str =="all"){
    			if(confirm("��ѡ�񽫶���"+str1+"��ֳɶ��������ȷ�ϼ�����")){           
  				if(str == "remove"){
  					str1 = str1.substring(1,str1.length-1);
  	            	//alert(str1);
  					
  	            	document.myform.action=basePath+"/remove";
  	            	document.myform.submit();
  	         	}
  	         	if(str == "all"){
  	            	document.myform.action="sdpack.jsp";
  	            	document.myform.submit();
  	         	}
  			}
  		}      
  	}
  	if(count > 1){
  		if(str=="add" || str =="all"){
  			if(confirm("��ѡ�񽫶���"+str1+"�����һ��ȷ�ϼ�����")){             
  				if(pandu()){
  					
  					document.myform.action=basePath+"/merge";
  					//document.myform.action="merge";
  					document.myform.submit();
  				}else{
  					alert("ֻ��ѡ�������������Ĵ���ң��ջ���ַ���ջ�������ͬ�Ķ������д����");
  					return false;
  				}
  			}
          }
          if(str=="remove"){
             alert("��ѡ��һ���������в��");
             return false;
          }      
  	}
  }
  //ȫѡ
	var flag=false;
  	function changeCheckBox(){		
  		var cboxes=document.myform.elements;
		var cbox=document.getElementById("selectAllCheckBox");
		for(i=0;i<cboxes.length;i++){
			if(cboxes[i].Type="checkbox" && cboxes[i].title=="cwcode"){
				if(cbox.checked==true){
					cboxes[i].checked=true;
					cbox.checked=true;
					flag=true;
				}else{
					cboxes[i].checked=false;
					cbox.checked=false;
					flag=false;
				}
			}
		}
	}
    //ֻѡһ��
    function chooseOneOnly(){
		if(chooseOneAtLeast()){
			var temp2=document.getElementById("cwcode").value;
			var temp3=temp2.substr(0,temp2.lastIndexOf(','));
			var temp4=temp3.split(',');
			if(temp4.length>=2){
				alert("��ѡ��һ����¼");
				return false;
			}else{
				document.getElementById("cwcode").value=temp3
				return true;
			}
		}else{
			var temp5=document.getElementById("cwcode").value;
			if(temp5==""){
				return false;
			}
			var temp6=temp5.substr(0,temp2.lastIndexOf(','));
			document.getElementById("cwcode").value=temp6;
			return true;
		}
	}
  //����Ƿ�ѡ��
  	function chooseOneAtLeast(){
		var obj = document.myform.elements;
		var k=0;
		for(var i=0;i<obj.length;i++){
			if (obj[i].name == "checkbox"){
				if(obj[i].checked == true){
					k+=1;
				}		
			}
		}
		if(k==0){
			alert("������ѡ��һ����¼");
			return false;
		}else{
			var temp="";
			for(var i=0;i<obj.length;i++){
				if (obj[i].name == "checkbox"){
					if(obj[i].checked == true){
						temp=obj[i].value + "," + temp;
					}		
				}
			}
			var temp1=temp;
			if(flag){
				temp1="";
				var s2=temp.split(',');
				//ȥ���ظ�
				var count=0;
				var del=new Array();
				for(var a=0;a<s2.length;a++){
					count=0;
					for(var b=0;b<s2.length;b++){
						if(s2[a]==s2[b]){
							count++;
						}
					}
					if(count==3){
						del.push(s2[a]);
					}
				}

				var s1=new Array();
				var f=true;
				for(var i=0;i<s2.length;i++){
					f=true;
					for(var j=0;j<s1.length;j++){
						if(s2[i]==s1[j]){
							f=false;
						}
					}
					for(var z=0;z<del.length;z++){
						if(s2[i]==del[z]){
							f=false;
						}
					}
					if(f){
						s1.push(s2[i]);	
					}
				}
				for(var k=0;k<s1.length;k++){
					if(temp1==""){
						temp1=temp1+s1[k];
					}else{
						temp1=temp1+","+s1[k];
					}
				}
			}			
			document.getElementById("cwcode").value = temp1;
			if(temp1==""){
				alert("������ѡ��һ����¼");
				return false;
			}
			return true;
		}
	}
  	//��������
  	function alonecustoms(){
		if(chooseOneAtLeast()){
			if(confirm("ȷ�ϵ�������")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/addAlonecustoms?isbg=y";
				//document.getElementById("myform").action='${pageContext.request.contextPath }/order/addAlonecustoms?isbg=y';
				document.getElementById("myform").submit();
			}
		}
	}	
  	//ȡ����������
	function noalonecustoms(){
		if(chooseOneAtLeast()){
			if(confirm("ȷ��ȡ����������")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+'/order/addAlonecustoms?isbg=n';
				//document.getElementById("myform").action='${pageContext.request.contextPath }/order/addAlonecustoms?isbg=n';
				document.getElementById("myform").submit();
			}
		}
	}
	
	function showdiv(){
		if(chooseOneAtLeast()){
			document.getElementById("xian").style.display="";
			document.getElementById("defaultCheck").checked=true;
			//document.getElementById("ShopConfirmLayer").style.display="";
		}
	}
	//��ӡ��ǩ��
	function lablePrint(){
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			document.getElementById("myform").action=basePath+"/order/queryPrinter";
			document.getElementById("myform").target="_blank";
			document.getElementById("myform").submit();    
	}
	//�رմ�ӡ��ʾ����
	function closediv(){
		document.getElementById("xian").style.display="none";
		document.getElementById("raval").value=2;
	}




   function loginout(){
		if(confirm("ȷ���˳���ǰ�û�")){
			document.getElementById("myform").action="${pageContext.request.contextPath}/order/loginout";
			document.getElementById("myform").target="";
			document.getElementById("myform").submit();	
		}	
		return false;
	}
	
	//��׷�ٱ�Ϊ��ɫ
	/*function greylink(){
	var links = document.getElementsByName("zhuizong");
	var tab = document.getElementById("attributeval");
	for(var index = 1 ; index < tab.rows.length ; index++){
		var cwsname = tab.rows[index].cells[8].innerHTML;
		if(cwsname != "����" || cwsname != "�Ƶ�" || cwsname != "����"){
			//links[index].setAttribute("disabled","true");
			links[index].style.color = "#B3B0B0";//��û��ʲô�ã�jquery����ֱ�ӵ���js
			}
		}
	
	}*/
/*	//��������
function moalwindow(e){
	var rowIndex =  e.parentNode.parentNode.rowIndex;//rowIndex=2
	var tab = document.getElementById("attributeval");
	var checkboxValue = document.getElementsByName("checkbox");
	
	var customecode = tab.rows[rowIndex].cells[1].innerText;//�ͻ����ſ��Բ鲻��
	var querycode = tab.rows[rowIndex].cells[3].innerHTML;//��ǧ���Ų鲻����
	var cwsname = tab.rows[rowIndex].cells[9].innerHTML;

	if(cwsname == "����" || cwsname == "�Ƶ�" || cwsname == "����" ){
		var location = (window.location+'').split('/');
		var basePath = location[0]+'//'+location[2]+'/'+location[3];
		window.showModalDialog(basePath+"/queryTrack?queryCode="+customecode,window, "dialogHeight:450px;dialogWidth:750px;status=no;");
		//window.showModalDialog("${pageContext.request.contextPath }/queryTrack?queryCode="+customecode,window, "dialogHeight:450px;dialogWidth:750px;status=no;");
	}

}*/



	