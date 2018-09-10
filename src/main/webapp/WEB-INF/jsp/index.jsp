<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页-列车到达出发辅助系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/sockjs.min.js"></script>
	
	<script type="text/javascript">
		<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String wsPath = "ws://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
	
		var sock;
		if  ('WebSocket' in window) {
			sock = new WebSocket("<%=wsPath%>websocket");
		} else if('MozWebSocket' in window) {
		  sock = new MozWebSocket("<%=wsPath%>websocket");
		} else {
		  sock = new SockJS("<%=basePath%>sockjs/websocket");
		}
		sock.onopen = function (e) {
			console.log(e);
		};
		sock.onmessage = function (e) {
			console.log(e.data);
		};

		$(document).ready(function(){
			$.ajax({
                type:"post",
                async:false,
                cache:false,
                url:"${pageContext.request.contextPath }/user/getUserRole",
                dataType:"json",
                success:function(data,status){
                	$("#userName").html(data[0].userName);
                	var j = 9999;
                	for(var i = 0;i<data.length;i++){
                        var menuId = data[i].mid;
                        var parentMenuId = data[i].parentMenuId;
                       	$("#"+parentMenuId).show();
                       	$("#"+menuId).show();
                       	if(parentMenuId != 0 && i <j){
                       		j = i;
                       		var url = $("#"+menuId).find('a').attr("_href");
                       		$("#mainFrame").attr("src", url);
                       	}
                    }
                }
            });
		});
		
	</script>
</head>
<body>
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo"><a href="index">列车到达出发辅助系统</a></div>
        <div class="left_open">
            <i title="展开左侧栏" class="iconfont">&#xe699;</i>
        </div>
        <ul class="layui-nav right" lay-filter="">
          <li class="layui-nav-item">
            <a href="javascript:;" id="userName"></a>
            <!-- <dl class="layui-nav-child"> 二级菜单
              <dd><a onclick="x_admin_show('个人信息','http://www.baidu.com')">个人信息</a></dd>
              <dd><a onclick="x_admin_show('切换帐号','http://www.baidu.com')">切换帐号</a></dd>
              <dd><a href="./login.html">退出</a></dd>
            </dl> -->
          </li>
          <li class="layui-nav-item to-index"><a href="/logout">注销</a></li>
        </ul>
        
    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
     <!-- 左侧菜单开始 -->
    <div class="left-nav">
      <div id="side-nav">
        <ul id="nav">
        	<li id="1000" style="display:none;">
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>用户管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                	 <li id="1001" style="display:none;">
                        <a _href="user/toSearch">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>用户查询</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <li id="2000" style="display:none;">
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>内勤管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                	<li id="2001" style="display:none;">
                        <a _href="scheduleJob/toSearch">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>调度查询</cite>
                        </a>
                    </li >
                    <li id="2002" style="display:none;">
                        <a _href="scheduleJob/toAdd">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>进/出站作业调度</cite>
                        </a>
                    </li>
                    <li id="2003" style="display:none;">
                        <a _href="jobFeedback/toSearch">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>调度反馈</cite>
                        </a>
                    </li>
                    <li id="2004" style="display:none;">
                        <a _href="jobFeedback/toSearch">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>调度报警提醒与查看</cite>
                        </a>
                    </li>
                    <li id="2005" style="display:none;">
                        <a _href="jobFeedback/toSearch">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>自动信息反馈</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li id="3000" style="display:none;">
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>岗点作业</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li id="3001" style="display:none;">
                        <a _href="scheduleJob/toSearchChehao">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>车号</cite>
                        </a>
                    </li >
                    <li id="3002" style="display:none;">
                        <a _href="scheduleJob/toSearchHuojian">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>货检</cite>
                        </a>
                    </li>
                    <li id="3003" style="display:none;">
                        <a _href="scheduleJob/toSearchLiejian">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>列检</cite>
                        </a>
                    </li>
                    <li id="3004" style="display:none;">
                        <a _href="scheduleJob/toSearchFangliu">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>防溜</cite>
                        </a>
                    </li>
                    <li id="3005" style="display:none;">
                        <a _href="scheduleJob/toSearchLiewei">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>列尾</cite>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
      </div>
    </div>
    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
          <ul class="layui-tab-title">
            <li>首页</li>
          </ul>
          <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe id="mainFrame" src='user/toSearch' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
          </div>
        </div>
    </div>
    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div class="copyright">版权所有：上海瀚所信息技术有限公司 copyright ©hansuotech</div>  
    </div>
</body>
</html>