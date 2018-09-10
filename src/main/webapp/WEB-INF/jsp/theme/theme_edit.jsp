<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  
  <head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
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
              <label for="themeName" class="layui-form-label">
                  <span class="x-red">*</span>主题名
              </label>
              <div class="layui-input-inline">
                  <input type="text"  id="themeName" name="name" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="module" class="layui-form-label">
                  <span class="x-red">*</span>主题模块
              </label>
              <div class="layui-input-inline">
              	  <select id="module" name="module" lay-verify="required" lay-search="" disabled="disabled">
		           <option value="">请选择</option>
		           <option value="index">index(主页)</option>
		           <option value="video">video</option>
		           <option value="banner">banner</option>
		           <option value="portal">portal</option>
		          </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="routeBegin" class="layui-form-label">
                  路线起点
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="routeBegin" name="routeBegin"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="routeEnd" class="layui-form-label">
                  路线终点
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="routeEnd" name="routeEnd"
                  autocomplete="off" class="layui-input">
              </div>
              <!-- <div class="layui-form-mid layui-word-aux">
                    请填写真实信息
              </div> -->
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="">
                  添加
              </button>
          </div>
          <input type="hidden" name="id" value=""/>
      </form>
    </div>
    <script>
    	$(document).ready(function(){
    		$("#module").val($(window.parent.document).find("#selectVal").val());
    	});
        layui.use(['form','layer'], function(){
            /* $ = layui.jquery; */
          var form = layui.form,
          	  layer = layui.layer;
          //监听提交
          form.on('submit(add)', function(data){
              //发异步，把数据提交后台
              $.ajax({
        			url:"${pageContext.request.contextPath }/theme/edit",
        			type:"post",
        			async: false,
        			cache : false,
        			data: data.field,
        			success:function(result){
        				if(result != 0){
        					layer.alert("编辑成功", {icon: 6},function () {
        						//刷新父窗口
        						window.parent.location.reload();
	  	      	                // 获得frame索引
	  	      	                var index = parent.layer.getFrameIndex(window.name);
	  	      	                //关闭当前frame
	  	      	                parent.layer.close(index);
	  	      	            });
        				}else{
        					layer.alert("添加失败");
        				}
        			}
        		})
              return false;
          });
        });
    </script>
  </body>

</html>