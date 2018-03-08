//键盘监听
document.onkeyup = function (e){
	var code;
	if (!e){
		var e = window.event;
	} 
	if (e.keyCode){
		code = e.keyCode; //IE
	}else if (e.which){
		code = e.which; //FF
	} 
	var act = document.activeElement.id;  //获得焦点的ID	
	if(act=="destination_2"){		
		var CL=document.getElementById("CountryList");
		var obj=document.getElementById("destination_2");	
		CL.style.display="none";		
		selectCityList(obj);		
	}
}
//判断字符串是否为空
function isNull( str ){
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}
//获取字段长度
function GetLength(str) {	 
	  var len = str.length,realLength;
	  realLength=len*10;
	  return realLength;
}
//匹配下拉框
function selectCityList(obj){	
	var CS=document.getElementById("CountryListSelect");
	var str=obj.value;
	var strContent="<table width='100%'  cellpadding='0' cellspacing='0'>";
	var array=achieveAllCity();//arrayCH:CH,arrayCN:CN,arrayCE:CE
	var arrayCH=array.arrayCH;
	var arrayCN=array.arrayCN;
	var arrayCE=array.arrayCE;
	var arrayText=new Array();	
	if(isNull(str)){
		CS.style.display="none";
		return;
	}
	/*包含某个字符串
	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].search(str)!=-1||arrayCE[i].search(str)!=-1){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	*/
	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].indexOf(str)==0||arrayCE[i].indexOf(str)==0){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	if(arrayText.length==0){
		CS.style.display="none";	
		return;
	}
	var width=60;
	var strLength;
	for(var i=0;i<arrayText.length;i++){
		strContent+="<tr height='20px'><td  onclick='Assignment(this);' style='padding-left:8px'>"+arrayText[i]+"</td></tr>";
		strLength=GetLength(arrayText[i]);		
		if(strLength>width){
			width=strLength;
		}
	}
	strContent+="</table>";	
	CS.style.height=arrayText.length*20;
	CS.style.width=width;	
	CS.innerHTML=strContent;
	CS.style.top=getElementOffset(obj).top+19;
	CS.style.left=getElementOffset(obj).left;
	CS.style.display="block";
}
//判断鼠标位置
function decideMouse(){
	var bool=true;
	var ev= ev || window.event;	
	var mousePos = mouseCoords(ev);	
	var CT=document.getElementById("CountryCityListShow");
	var pos=getElementOffset(CT);	
	if(mousePos.x>=pos.left&&mousePos.x<=(pos.left+550)&&mousePos.y>=pos.top&&mousePos.y<=(pos.top+pos.height)){		
		bool=false;
	}	
	return bool;
}
//获取元素坐标
function getElementOffset(e)
{
	var t = e.offsetTop;
	var l = e.offsetLeft;
	var w = e.offsetWidth;
	var h = e.offsetHeight-1;

	while(e=e.offsetParent) {
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	return {top : t,left : l,width : w,height : h}
}
//获取鼠标坐标
function mouseCoords(ev) 
{ 
	if(ev.pageX || ev.pageY){		 
		return {x:ev.pageX, y:ev.pageY}; 
	}	
	if(document.body.scrollTop!=0||document.body.scrollLeft!=0||document.body.clientLeft!=0||document.body.clientTop!=0){
		return { 
			x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, 
			y:ev.clientY + document.body.scrollTop - document.body.clientTop 
			};
	}

	if(document.documentElement.scrollTop!=0||document.documentElement.scrollLeft!=0||document.documentElement.clientLeft!=0||document.documentElement.clientTop!=0){
		return { 
			x:ev.clientX + document.documentElement.scrollLeft - document.documentElement.clientLeft, 
			y:ev.clientY + document.documentElement.scrollTop - document.documentElement.clientTop 
			}; 
	}
	return{
		x:ev.clientX, 
		y:ev.clientY 
	}		
	
	
} 
//选择框初始化
function setLeft(obj){	
	var CL=document.getElementById("CountryList");
	var CT=document.getElementById("CountryTitie");
	var list=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","Y","Z"];//O W X没有对应国家
	var str="";	
	for(var i=0;i<list.length;i++){
		str+="<a onclick='changeContent(this);'>"+list[i]+"</a>";
	}	
	selectCity("A");	
	CT.innerHTML=str;		
	CL.style.top=getElementOffset(obj).top+19;
	CL.style.left=getElementOffset(obj).left;//obj.offsetLeft;
	CL.style.display="block";	
}
//更改div内容
function changeContent(obj){
	selectCity(obj.innerText);	
}
//隐藏div模块
function setPlay(){
	var CL=document.getElementById("CountryList");	
	if(decideMouse()){	
		CL.style.display="none";
	}
}
//获取数据信息
function achieveAllCity(){
	var CS=document.getElementById("CountryListSorting");
	var CH=document.getElementById("countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("countryDtdt_ename").value;
	//转义
	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");
	
	CE=CE.substring(1,CE.length-1).split(",")

	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	return {arrayCH:CH,arrayCN:CN,arrayCE:CE};	
}
//查找匹配国家
function selectCity(str){
	var CLS=document.getElementById("CountryListSelect");
	var CS=document.getElementById("CountryListSorting");
	var CH=document.getElementById("countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("countryDtdt_ename").value;
	//转义
	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");
	CE=CE.substring(1,CE.length-1).split(",")
	
	var CTL=document.getElementById("CountryList");
	
	
	var counStr="";
	CLS.style.display="none";
	
	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	var arrayCH = new Array();
	var arrayCN = new Array();
	var arrayCE = new Array();
	for(var i=0;i<CH.length;i++){					
		if(str==CE[i].charAt(0)){
			arrayCH.push(CH[i]);
			arrayCN.push(CN[i]);
			arrayCE.push(CE[i]);
		}
	}
	counStr="<table width='100%'cellpadding='0' cellspacing='0' >";	
	for(var i=0;i<arrayCH.length;i++){						
			if((i+1)%2==0){
				counStr+="<td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td></tr>";
			}else if(arrayCH.length%2==1&&(i+1)==arrayCH.length){
				counStr+="<tr height='25px'><td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td><td></td></tr>";
			}else{
				counStr+="<tr height='25px'><td weidth='50%'><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td>";
			}			
	}
	counStr+="</table>";	
	if(arrayCH.length%2==0){
		CTL.style.height=arrayCH.length*25/2+30;
	}else{
		CTL.style.height=arrayCH.length*25/2+25+30;
	}
	
	CS.innerHTML=counStr;	
}
//选定国家赋值
function Assignment(obj){
	var str=obj.innerText;
	str=str.replace("VIRGIN ISLANDS (US),VIRGIN ISLANDS &#40US&#41");
	str=str.replace("SOMALILAND, REP OF (NORTH SOMALIA),SOMALILAND, REP OF &#40NORTH SOMALIA&#41");	
	str=str.replace("VIRGIN ISLANDS (BRITISH),VIRGIN ISLANDS &#40BRITISH&#41");	
	str=str.replace("IRAN (ISLAMIC REPUBLIC OF),IRAN &#40ISLAMIC REPUBLIC OF&#41");
	str=str.replace("GUYANA (BRITISH),GUYANA &#40BRITISH&#41");	
	
	var str1,str2;
	str1=str.substring(0,str.lastIndexOf("("));
	str2=str.substring(str.lastIndexOf("(")+1,str.lastIndexOf(")"));	
	document.getElementById("destination_2").value=str1;
	document.getElementById("countryCode").value=str2;
	document.getElementById("CountryList").style.display="none";
	document.getElementById("CountryListSelect").style.display="none";	
	
}