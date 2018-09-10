<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>车企管理-列车到达出发辅助系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
    <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">基础管理</a>
        <a>
          <cite>车企管理</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row" align="center">
	      <div class="layui-form-item">
		    <div class="layui-inline">
		       <input type="text" name="name"    id="name"  placeholder="企业名称" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
		        <input type="text" name="address" id="address" placeholder="企业地址" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
	          	<input type="text" name="owner"   id="owner" placeholder="法人代表" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
	          <button class="layui-btn layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
		    </div>
		  </div>
      </div>
      <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加','./enterprise_add',600,450)"><i class="layui-icon"></i>添加</button>
        <span id="total" class="x-right" style="line-height:40px"></span>
      </xblock>
      <table class="layui-table" id="enterprise" lay-filter="demo">
      </table>
    </div>
    
    <script type="text/html" id="barDemo">
       <button class='layui-btn  layui-btn-xs' lay-event="edit"><i class='layui-icon'>&#xe642;</i></button>
       <button class='layui-btn  layui-btn-danger layui-btn-xs' lay-event="del"><i class='layui-icon'>&#xe640;</i></button>
	</script>
    <script type="text/html" id="indexTpl">
       {{d.LAY_TABLE_INDEX+1}}
	</script>
    <script>
      
       
	 layui.use('table', function(){ 
		   
         //table加载
       	 var table = layui.table;
			 table.render({
       	      elem: '#enterprise'
       	     ,url: '${pageContext.request.contextPath }/show'
       	     ,where: {urltype:"enterprise"} //如果无需传递额外参数，可不加该参数
             ,page:{prev:['上一页'],next:['下一页'],layout: ['prev', 'page', 'next']}
       	     ,cols: [[
       	       {field: '',width:'10%', title: '序号', sort: true,align:'center',templet: '#indexTpl'}
       	      ,{field:'enterpriseName', width:'15%', sort: true,title: '企业名称'}
       	      ,{field:'enterpriseAddress', width:'15%', sort: true,title: '企业地址'}
       	      ,{field:'enterpriseTel', width:'15%', title: '联系电话',sort: true}
       	      ,{field:'enterpriseOwner', width:'15%', sort: true,title: '法人代表'}
       	      ,{field:'remark', width:'15%', title: '备注'}
    	      ,{field:'', width:'15%', align:'center',title: '操作', toolbar: '#barDemo'}
       	        
       	     ]]
       	     ,id: 'reload'
   	    	 ,done: function(res, curr, count){
		      			$("#total").text("总共数据："+res.count+" 条");
 	    	        }
       	     
    		 });
			 
			 //监听工具条事件
			 table.on('tool(demo)', function(obj){
			     var data = obj.data;
			     if(obj.event === 'edit'){
			        //编辑
			    	edit(data.id);
			     }else if(obj.event === 'del'){
			    	//删除
			    	del(obj,data.id);
			     } 
			 });
			 
			 //table重载
			 var $ = layui.$, active = {
		        reload: function(){
		        	
			      var name    =$("#name").val();
			  	  var address =$("#address").val();
			  	  var owner   =$("#owner").val();
			  	  
			      //执行重载
			      table.reload('reload', {
			        page: {
			          curr: 1 //重新从第 1 页开始
			        }
			        ,where: {
			        	urltype:"enterprise",
		      			name:name,
		      			address:address,
		      			owner:owner
			        }
			      });
		      }
		 }
		 //监听按钮点击
		 $('.layui-row .layui-btn').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		 }); 
    });
       
   /*打开编辑页面*/
   function edit(id){
	   var datajson="";
       var url = "${pageContext.request.contextPath }/selectone";
  	    $.ajax({
      		type : "GET",
      		url : url,
      		data:{
   			id:id,
   			urltype:"enterprise",
       	},
      		dataType : "json",
      		success : function(data) {
      			var result = eval('(' + data + ')');
      			if(result.code=="0000"){
      				datajson=JSON.stringify(result);
      				layer.open({
      		  	        type: 2,
      		  	        area: ['600px', '450px'],
      		  	        fix: false, //不固定
      		  	        maxmin: true,
      		  	        shadeClose: true,
      		  	        shade:0.4,
      		  	        title: "编辑",
      		  	        content: ["${pageContext.request.contextPath}/enterprise_edit?args="+encodeURIComponent(datajson),"no"]
      		  	    });
      			}
      		}
  	    });
  	    
 	    
    }
  
    /*删除*/
    function del(obj,id){
      layer.confirm('确认要删除吗？',function(index){
	       var url = "${pageContext.request.contextPath }/delete";
	   	   $.ajax({
	       		type : "POST",
	       		data:{
	       			id:id,
	       			urltype:"enterprise",
	           	},
	       		url : url,
	       		dataType : "json",
	       		success : function(data) {
	       			var result = eval('(' + data + ')');
					if(result.code=="0000"){
						$(obj).parents("tr").remove();
				        layer.msg('已删除!',{icon:1,time:1000});
	  		            	window.location.reload(); //刷新页面
	       			}
	       		}
	   	    });
      	});
    }
    </script>
  </body>

</html>