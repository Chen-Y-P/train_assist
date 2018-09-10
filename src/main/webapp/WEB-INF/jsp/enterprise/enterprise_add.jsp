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
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-body">
        <form class="layui-form">
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>企业名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="name" name="name"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>企业地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="address" name="address"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>联系电话
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="tel" name="tel"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                  <span class="x-red">*</span>法人代表
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="owner" name="owner"  lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
              <div class="layui-form-mid layui-word-aux">
                                                              请填写真实信息
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
                                                             备注
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="remark" name="remark" 
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="">
                  增加
              </button>
          </div>
      </form>
    </div>
    <script>
        layui.use(['form','layer'], function(){
          $ = layui.jquery;
          var form = layui.form
         ,layer = layui.layer;
        
          //监听提交
          form.on('submit(add)', function(data){
        	  console.log(data.field);
        	  var name    =data.field.name;
        	  var address =data.field.address;
        	  var tel     =data.field.tel;
        	  var owner   =data.field.owner;
        	  var remark  =data.field.remark;
	       	  $.ajax({
	   		    type : "POST",
	   	        url : "${pageContext.request.contextPath }/add",   
		   	    data:{
		   	    	urltype:"enterprise",
		   	    	name:name,
		   	    	address:address,
		   	    	tel:tel,
		   	    	owner:owner,
		   	    	remark:remark,
	         	},
	   	        dataType:"json",      
	   			success:function(data){
	   				var result = eval('(' + data + ')');
	   				if(result.code=="0000"){
	   		            layer.alert("增加成功", {icon: 6},function () {
	   		            	window.parent.location.reload(); //刷新父页面
	   		                // 获得frame索引
	   		                var index = parent.layer.getFrameIndex(window.name);
	   		                //关闭当前frame
	   		                parent.layer.close(index);
	   		            });
	   				}
	   			}
	   	      })    
              return false;
          });
          
          
        });
    </script>
  </body>
</html>