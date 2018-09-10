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
          <input type="hidden" id="id" name="id"/>
          <div class="layui-form-item">
              <label for="userName" class="layui-form-label">
                  <span class="x-red">*</span>用户名
              </label>
              <div class="layui-input-inline">
                  <input type="text"  id="userName" name="userName" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="password" class="layui-form-label">
                  <span class="x-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="password"  id="password" name="password" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          
           <div class="layui-form-item">
              <label for="aliases" class="layui-form-label">
                  <span class="x-red">*</span>用户别名
              </label>
              <div class="layui-input-inline">
                  <input type="text"  id="aliases" name="aliases" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="deptId" class="layui-form-label">
                  <span class="x-red">*</span>场
              </label>
              <div class="layui-input-inline">
              	  <select id="deptId" name="deptId" lay-verify="required" lay-search="">
		           <option value="">请选择</option>
		           <option value="0">车站</option>
		           <option value="1">场1</option>
		           <option value="2">场2</option>
		          </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="postId" class="layui-form-label">
                  <span class="x-red">*</span>岗位
              </label>
              <div class="layui-input-inline">
              	  <select id="postId" name="postId" lay-verify="required" lay-search="">
		           <option value="">请选择</option>
		           <option value="0">系统管理员</option>
		           <option value="1">内勤助理</option>
		           <option value="2">车号</option>
		           <option value="3">货检</option>
		           <option value="4">列检</option>
		           <option value="5">防溜</option>
		           <option value="6">列尾</option>
		           <option value="7">安全作业指挥中心</option>
		          </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label  class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="">
                  添加
              </button>
          </div>
      </form>
    </div>
    <script>
    	$(document).ready(function(){
    		$("#deptId").val($(window.parent.document).find("#selectDeptId").val());
    		$("#postId").val($(window.parent.document).find("#selectPostId").val());
    	});
    
        layui.use(['form','layer'], function(){
            /* $ = layui.jquery; */
          var form = layui.form,
          	  layer = layui.layer;
          //监听提交
          form.on('submit(add)', function(data){
              //发异步，把数据提交后台
              $.ajax({
        			url:"${pageContext.request.contextPath }/user/edit",
        			type:"post",
        			async: false,
        			cache : false,
        			data: data.field,
        			success:function(result){
        				if(result == -1){
        					layer.alert("用户名重复,添加失败");
        				}else if(result != 0){
        					layer.alert("修改成功", {icon: 6},function () {
        						//刷新父窗口
        						window.parent.location.reload();
	  	      	                // 获得frame索引
	  	      	                var index = parent.layer.getFrameIndex(window.name);
	  	      	                //关闭当前frame
	  	      	                parent.layer.close(index);
	  	      	            });
        				}else{
        					layer.alert("修改失败");
        				}
        			}
        		})
              return false;
          });
        });
    </script>
  </body>
</html>