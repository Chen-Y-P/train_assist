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
              <label for="userName" class="layui-form-label">
                  	用户名
              </label>
              <div class="layui-input-inline">
                  <input type="text"  id="userName" name="userName" lay-verify="required"
                  autocomplete="off" class="layui-input" disabled="disabled" value="${user.userName}">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="password" class="layui-form-label">
                  	密码
              </label>
              <div class="layui-input-inline">
                  <input type="password"  id="password" name="password" lay-verify="required"
                  autocomplete="off" class="layui-input" disabled="disabled" value="${user.password}">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="aliases" class="layui-form-label">
                  	用户别名
              </label>
              <div class="layui-input-inline">
                  <input type="text"  id="aliases" name="aliases" lay-verify="required"
                  autocomplete="off" class="layui-input" disabled="disabled" value="${user.aliases}">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="deptName" class="layui-form-label">
                  	场
              </label>
              <div class="layui-input-inline">
              	  <input type="text"  id="deptName" name="deptName" lay-verify="required"
                  autocomplete="off" class="layui-input" disabled="disabled" value="${user.deptName}">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="postName" class="layui-form-label">
                	 岗位
              </label>
              <div class="layui-input-inline">
              	  <div class="layui-input-inline">
              	  <input type="text"  id="postName" name="postName" lay-verify="required"
                  autocomplete="off" class="layui-input" disabled="disabled" value="${user.postName}">
              </div>
              </div>
          </div>
      </form>
    </div>
  </body>

</html>