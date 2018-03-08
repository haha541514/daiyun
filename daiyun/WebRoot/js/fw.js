$.extend({
	trsSort: function(trs, columnIndex, isNum, sortID){
		trs.sort(function(tr1, tr2){
			var $td1 = $(tr1).find('td').filter(function(index){return index == columnIndex;});
			var $td2 = $(tr2).find('td').filter(function(index){return index == columnIndex;});
			var str1 = $td1.text(), str2 = $td2.text();
			if (isNum) {
				var num1 = parseFloat(str1), num2 = parseFloat(str2);
				num1 = isNaN(num1) ? 0 : num1;
				num2 = isNaN(num2) ? 0 : num2;
				return (num1 - num2) * sortID;
			}
			return str1.localeCompare(str2) * sortID;
		});
	},
	simpleTableSort: function(td, columnIndex, isNum){
		var $td = $(td);
		var $table = $td.parent('tr').parent('thead').parent('table');
		var $headTds = $table.find('thead').find('td,th');
		var $tbody = $table.find('tbody');
		var $trs = $tbody.find('tr');
		var sortType = $td.attr('sort');
		var sortID = 1;
		if (sortType == 'asc') {
			sortType = 'desc';
			if ($td.find('img').length > 0) {
				$td.find('img').attr('src', '../images/desc.gif');
			} else {
				$td.append('<img src="../images/desc.gif"/>');
			}
			sortID = -1;
		} else {
			sortType = 'asc';
			if ($td.find('img').length > 0) {
				$td.find('img').attr('src', '../images/asc.gif');
			} else {
				$td.append('<img src="../images/asc.gif"/>');
			}
		}
		$.trsSort($trs, columnIndex, isNum, sortID);
		$tbody.empty();
		$tbody.append($trs);
		$td.attr('sort', sortType);
		//去掉其他列的排序图标
		$headTds.filter(function(k, n){return n != td}).each(function(i, td){
			$(td).find('img').remove();
		});
	}
});
$.fn.extend({
	  /**
	   * 表格选中行变色插件
	   */
	  changecolor: function(options) {
		var defaults = {
			selectedColor: 'gainsboro' //选中后的颜色,默认淡灰色
		}; 
	    options = $.extend(defaults, options); 
	    return this.each(function() { 
	    	var $this = $(this);
	    	var $trs = $this.find('tr').filter(function(index){return index >= 1;});
	    	var selectedColor = options.selectedColor;
	    	$trs.each(function(i, tr){
	    		$(tr).bind('click', function(event){
	    			$trs.each(function(i, n) {
	    				if (n == tr) {
	    					$(n).css('background-color', selectedColor);
	    				} else {
	    					$(n).css('background-color', 'white');
	    				}
	    			});
	    		});
	    	});
	    });
	  },
	  /**
	   * 排序
	   */
	  tableSort: function(options){
		  var defaults = {
				  numClmIndex: []
		  }; 
		  options = $.extend(defaults, options);
		  return this.each(function() { 
		    	var $this = $(this);
		    	var $thead = $this.find('thead');
		    	var $tbody = $this.find('tbody');
		    	var $headTds = $thead.find('td,th');
				$headTds.each(function(i, td){
					var $td = $(td);
					$td.css('cursor', 'pointer');
					$td.bind({
						click: function(event){
							var sortType = $td.attr('sort');
							var sortID = 1;
							if (sortType == 'asc') {
								sortType = 'desc';
								if ($td.find('img').length > 0) {
									$td.find('img').attr('src', '../images/desc.gif');
								} else {
									$td.append('<img src="../images/desc.gif"/>');
								}
								sortID = -1;
							} else {
								sortType = 'asc';
								if ($td.find('img').length > 0) {
									$td.find('img').attr('src', '../images/asc.gif');
								} else {
									$td.append('<img src="../images/asc.gif"/>');
								}
							}
			    			var columnIndex = $td.index();//排序列索引
			    			//判断是否为数字列
			    			var isNum = false;
			    			if (options.numClmIndex.length > 0 && 
			    					$.inArray(columnIndex, options.numClmIndex) > -1) {
			    				isNum = true;
							}
			    			var $trs = $tbody.find('tr');
			    			$.trsSort($trs, columnIndex, isNum, sortID);
			    			$tbody.empty();
			    			$tbody.append($trs);
			    			$td.attr('sort', sortType);
			    			//去掉其他列的排序图标
			    			$headTds.filter(function(index){return index != columnIndex}).each(function(i, td){
			    				$(td).find('img').remove();
			    			});
			    			$this.changecolor();
			    		}
					});
				});
		  });
	  },
	  /**
	   * 排序（兼容插件tableheader.js）
	   */
	  tableSortFix: function(options){
		  var defaults = {
				  numClmIndex: []
		  }; 
		  options = $.extend(defaults, options);
		  return this.each(function() { 
		    	var $this = $(this);
		    	var $thead = $this.find('thead');
		    	var $tbody = $this.find('tbody');
		    	var $headTds = $thead.find('td,th');
				$headTds.each(function(i, td){
					var $td = $(td);
					$td.css('cursor', 'pointer');
					$td.bind({
						click: function(event){
							var sortType = $td.attr('sort');
							var sortID = 1;
							if (sortType == 'asc') {
								sortType = 'desc';
								if ($td.find('img').length > 0) {
									$td.find('img').attr('src', '../images/desc.gif');
								} else {
									$td.append('<img src="../images/desc.gif"/>');
								}
								sortID = -1;
							} else {
								sortType = 'asc';
								if ($td.find('img').length > 0) {
									$td.find('img').attr('src', '../images/asc.gif');
								} else {
									$td.append('<img src="../images/asc.gif"/>');
								}
							}
							$td.attr('sort', sortType);
			    			var columnIndex = $td.index();//排序列索引
			    			var isNum = false;
			    			//判断是否为数字列
			    			if (options.numClmIndex.length > 0 && 
			    					$.inArray(columnIndex, options.numClmIndex) > -1) {
			    				isNum = true;
							}
			    			var tableID = $this.attr('id').split('_')[0];
			    			var $tables = $('table[id^="' + tableID + '"]');
			    			$tables.each(function(i, table){
			    				$this = $(table);
			    				$thead = $this.find('thead');
			    				$headTds = $thead.find('td,th');
			    				//去掉其他列的排序图标
				    			$headTds.filter(function(index){return index != columnIndex}).each(function(i, td){
				    				$(td).find('img').remove();
				    			});
			    				$tbody = $this.find('tbody');
			    				var $trs = $tbody.find('tr');
				    			$.trsSort($trs, columnIndex, isNum, sortID);
			    				$tbody.empty();
				    			$tbody.append($trs);
				    			$this.changecolor();
			    			});
			    		}
					});
				});
		  });
	  }
});
