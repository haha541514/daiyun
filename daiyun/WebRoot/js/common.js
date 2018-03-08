function OpenMenu(data){
	var d=document;
	for(var i=1;i<=6;i++){
		if(data==i){
			d.getElementById("menu"+i).style.display="";
			}
		else{
			d.getElementById("menu"+i).style.display="none";
			}
		}
	}
	
function CloseMenu(){
	var d=document;
	for(var i=1;i<=6;i++){
			d.getElementById("menu"+i).style.display="none";	
		}
	}