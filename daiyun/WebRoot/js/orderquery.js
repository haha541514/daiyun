

	var URL = window.location.href;

	//刷新
	var doReset = function(){
		mysearch();
	}
	
	//订单详情
	function mydetail(){
		if(chooseOneOnly()){
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			var url = basePath+"/order/queryOrdersDetail?cw_code=" +document.getElementById("cwcode").value ;
			window.open(url);
		}
	}
	//删除
	 function mydelete(){
			if(chooseOneAtLeast()){
				if(confirm("是否删除?删除后如果想要恢复，请到'订单回收站'进行操作！")){
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					
					document.getElementById("myform").action=basePath+"/order/deleteTransientOrders";
					document.getElementById("myform").submit();
				}			
			}
		}
	//撤销,已申报撤销为暂存
	function myrecover(){
		if(chooseOneAtLeast()){
			if(confirm("确认撤销")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/newRecoverDeclaredOrders";	
				document.getElementById("myform").submit();
			}
		}
	}
	//已打印撤销为缓存
	function printRecover(){
		if(chooseOneAtLeast()){
			if(confirm("确认撤销")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/newRecoverOrders";
				document.getElementById("myform").submit();
				alert("撤销成功");
			}
		}
	}
	//重复打印
	function myprint(){
		if(chooseOneAtLeast()){	
			$(".button3").append($("#print_format"));//界面添加
			document.getElementById("xian").style.display="";
			document.getElementById("defaultCheck").checked=true;
		}
	}	
	//打印发票
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
	//扣件,判断已收货的状态。,已收货状态中SO状态不允许配货
	function detain(){
		if(chooseOneAtLeast()){
			if(checkDetain()){
				if(AgreeAllocation()){
					if(confirm("确认设为扣件")){
						var location = (window.location+'').split('/');
						var basePath = location[0]+'//'+location[2]+'/'+location[3];
						document.getElementById("myform").action=basePath+"/order/detainOrders";
	
						//document.getElementById("myform").action="${pageContext.request.contextPath }/order/detainOrders";
						document.getElementById("myform").submit();
						alert("扣件成功");
					}
				}	
			}
		}
	}
	//配货
	function myallocate() {
		if(chooseOneAtLeast()) {
			if(confirm("确认配货")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/allocate";

				//document.getElementById("myform").action="${pageContext.request.contextPath }/order/allocate";
				document.getElementById("myform").submit();
			}
		}	
	}
	//完成配货
	function completeAllocate(){
		if(chooseOneAtLeast()){
				if(confirm("确认完成配货？")){
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/completeAllocate";
					
					//document.getElementById("myform").action="${pageContext.request.contextPath }/order/completeAllocate";
					document.getElementById("myform").submit();
					alert("已配货成功");
				}
		}
	}
	//确认配货
	function checkDetain(){
		var count=0;
		var checkbox1 = document.getElementsByName("checkbox1");
		for(var i = 0;i<checkbox1.length;i++){
			if(checkbox1[i].value=="确定扣件"&& checkbox1[i].checked==true){
				count++;
			}
		}
		if(count>0)	{
			alert('请选择扣件状态不是"确定扣件"的记录');
			return false;
		}else{
			return true;
		}
	}
	//允许配货,获取table选中行的cws_name并判断,如果是出货，则不允许扣件
	function AgreeAllocation(){
		var table = document.getElementById("attributeval");
		var checkbox = $('input[name="checkbox"]');
		for(var index = 0 ; index < checkbox.length ; index++ ){
			if(checkbox[index].checked == true){
				var strCwsname = table.rows[index+1].cells[9].innerHTML;//获取运单状态，已打印，制单，到货允许扣件
				if(strCwsname == '已打印' || strCwsname == '制单' || strCwsname == '到货'){
					
					return true;
				}else{
					alert("已出货,不能扣件");
					return false;
				}
			}
		}
	}
	
	
	
	// 删除
	var mydelete =  function(){
		if(chooseOneAtLeast()){
			if(confirm("是否删除?删除后如果想要恢复，请到'订单回收站'进行操作！")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/deleteTransientOrders";
				//document.getElementById("myform").action='${pageContext.request.contextPath }/order/deleteTransientOrders';
				document.getElementById("myform").submit();
			}			
		}
	}
	// 申报
	function mydeclare(){
		if(chooseOneAtLeast()){
			if(confirm("确认申报")){	
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/declare";
					//document.getElementById("myform").action="${pageContext.request.contextPath }/order/declare";
					document.getElementById("myform").submit();
			}
		}
	}
	// 申报并完成
	function mycomplete(){
		if(chooseOneAtLeast()){
			if(confirm("是否申报并完成？")){
					Ext.MessageBox.wait("申报中...", "请稍候");
					var location = (window.location+'').split('/');
					var basePath = location[0]+'//'+location[2]+'/'+location[3];
					document.getElementById("myform").action=basePath+"/order/declareandcomplete";
					//document.getElementById("myform").action='${pageContext.request.contextPath }/order/declareandcomplete';
					document.getElementById("myform").submit();	
			}		
		}
	}
	/* 条件批量删除 */
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
			alert("请至少输入一个条件!");
			return;
		}else{
			if(confirm("确定要批量删除吗?")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+'/order/deleteTransientOrders?customerewbcode='+customerewbcode+
				'&strHwconsigneename='+strHwconsigneename+'&pkCode='+pkCode+'&strHwConsigneeCompany='+strHwConsigneeCompany+'&=startdate'+startdate+
				'&enddate='+enddate+'&=buyerid'+buyerid+'&=transactionid'+transactionid;
				document.getElementById("myform").submit();
			}
		}
	}
	// 修改货物信息
	//修改货物信息
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
	
  //返回复选框选中个数
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
  //返回复选框选中的订单号 
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
    
  //判断选中的货物渠道，名称，地址等是否完全是同
   function pandu(){
  	   var chname = document.getElementsByName("checkbox");
  	   var tab = document.getElementById("attributeval");
  	   var count = 0;
  	   var array = new Array();
  	   var strcw ="";
  	   for(var i = 0;i<chname.length;i++){
  	      if(chname[i].checked == true){		//将两条数据分别赋给数组
  	          var rowle = chname[i].parentElement.parentElement.rowIndex;//row = 9 
  	          strcw = tab.rows[rowle].cells[5].innerHTML+tab.rows[rowle].cells[7].innerHTML+tab.rows[rowle].cells[7].innerHTML;
  	  		  array[count] = strcw;
  	          count++;
  	      }
  	   }
  	   var flag = "";
  	   for(var k = 0;k<count-1;k++){	//根据列数判断，判断两条数据是否均相同
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

  	 //打包
    function doPack(str){
       var count = check();
       var str1 = checkvalue();
       var location = (window.location+'').split('/');
       var basePath = location[0]+'//'+location[2]+'/'+location[3];
		
       str1 = str1.substring(0,str1.length-1);
       if(count == 0){
          if(str=="add" || str =="all"){
             alert("请选择多个订单进行打包");
             return false;
          }
          if(str=="remove" || str =="all"){
             alert("请选择一个订单进行拆分");
             return false;
          }
       }
       if(count == 1){
          if(str=="add"){
             alert("请选择多个订单进行打包");
             return false;
          }
          if(str=="remove" || str =="all"){
    			if(confirm("您选择将订单"+str1+"拆分成多个包裹，确认继续吗？")){           
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
  			if(confirm("您选择将订单"+str1+"打包在一起，确认继续吗？")){             
  				if(pandu()){
  					
  					document.myform.action=basePath+"/merge";
  					//document.myform.action="merge";
  					document.myform.submit();
  				}else{
  					alert("只能选择物流渠道，寄达国家，收货地址，收货人名相同的订单进行打包！");
  					return false;
  				}
  			}
          }
          if(str=="remove"){
             alert("请选择一个订单进行拆分");
             return false;
          }      
  	}
  }
  //全选
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
    //只选一条
    function chooseOneOnly(){
		if(chooseOneAtLeast()){
			var temp2=document.getElementById("cwcode").value;
			var temp3=temp2.substr(0,temp2.lastIndexOf(','));
			var temp4=temp3.split(',');
			if(temp4.length>=2){
				alert("请选择一条记录");
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
  //检查是否选中
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
			alert("请至少选择一条记录");
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
				//去除重复
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
				alert("请至少选择一条记录");
				return false;
			}
			return true;
		}
	}
  	//单独报关
  	function alonecustoms(){
		if(chooseOneAtLeast()){
			if(confirm("确认单独报关")){
				var location = (window.location+'').split('/');
				var basePath = location[0]+'//'+location[2]+'/'+location[3];
				document.getElementById("myform").action=basePath+"/order/addAlonecustoms?isbg=y";
				//document.getElementById("myform").action='${pageContext.request.contextPath }/order/addAlonecustoms?isbg=y';
				document.getElementById("myform").submit();
			}
		}
	}	
  	//取消单独报关
	function noalonecustoms(){
		if(chooseOneAtLeast()){
			if(confirm("确认取消单独报关")){
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
	//打印标签，
	function lablePrint(){
			var location = (window.location+'').split('/');
			var basePath = location[0]+'//'+location[2]+'/'+location[3];
			document.getElementById("myform").action=basePath+"/order/queryPrinter";
			document.getElementById("myform").target="_blank";
			document.getElementById("myform").submit();    
	}
	//关闭打印提示窗口
	function closediv(){
		document.getElementById("xian").style.display="none";
		document.getElementById("raval").value=2;
	}




   function loginout(){
		if(confirm("确认退出当前用户")){
			document.getElementById("myform").action="${pageContext.request.contextPath}/order/loginout";
			document.getElementById("myform").target="";
			document.getElementById("myform").submit();	
		}	
		return false;
	}
	
	//按追踪变为灰色
	/*function greylink(){
	var links = document.getElementsByName("zhuizong");
	var tab = document.getElementById("attributeval");
	for(var index = 1 ; index < tab.rows.length ; index++){
		var cwsname = tab.rows[index].cells[8].innerHTML;
		if(cwsname != "到货" || cwsname != "制单" || cwsname != "出货"){
			//links[index].setAttribute("disabled","true");
			links[index].style.color = "#B3B0B0";//并没有什么用，jquery可以直接调用js
			}
		}
	
	}*/
/*	//弹出窗口
function moalwindow(e){
	var rowIndex =  e.parentNode.parentNode.rowIndex;//rowIndex=2
	var tab = document.getElementById("attributeval");
	var checkboxValue = document.getElementsByName("checkbox");
	
	var customecode = tab.rows[rowIndex].cells[1].innerText;//客户单号可以查不来
	var querycode = tab.rows[rowIndex].cells[3].innerHTML;//百千单号查不出来
	var cwsname = tab.rows[rowIndex].cells[9].innerHTML;

	if(cwsname == "到货" || cwsname == "制单" || cwsname == "出货" ){
		var location = (window.location+'').split('/');
		var basePath = location[0]+'//'+location[2]+'/'+location[3];
		window.showModalDialog(basePath+"/queryTrack?queryCode="+customecode,window, "dialogHeight:450px;dialogWidth:750px;status=no;");
		//window.showModalDialog("${pageContext.request.contextPath }/queryTrack?queryCode="+customecode,window, "dialogHeight:450px;dialogWidth:750px;status=no;");
	}

}*/



	