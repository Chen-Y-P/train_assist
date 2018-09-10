<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>列车到达出发辅助系统</title>
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
        <a>
          <cite>调度反馈</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
    
      <div class="layui-row" align="center">
	      <div class="layui-form-item">
		    <div class="layui-inline">
	          <button id="searchBtn" class="layui-btn layui-btn"  data-type="reload"><i class="layui-icon">&#xe615;</i></button>
		    </div>
		  </div>
      </div>
      
      <table id="resultTable" class="layui-hide" lay-data="{id:resultTable}" lay-filter="demo">
      </table>
      <div id="page" class="page">
       
      </div>
    
    <script type="text/html" id="mytoolBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" title="查看"><i class='layui-icon'>&#xe64c;</i></a>
	</script>
    <script type="text/html" id="indexTpl">
       {{d.LAY_TABLE_INDEX+1}}
	</script>
	
<!-- 	1列检作业接收时分，2商检作业接收时分，
3车号作业接收时分，4防溜作业接收时分,5列尾作业接收时分，
6列检作业反馈时分，7商检作业反馈时分，
8车号作业反馈时分，9防溜作业反馈时分,10列尾作业反馈时分 -->
	<script type="text/html" id="jobTypeStr">
    {{#  if(d.jobType == 1){ }}
     	列检作业接收完成
    {{#  } }}
	{{#  if(d.jobType == 2){ }}
     	商检作业接收完成
    {{#  } }}
    {{#  if(d.jobType == 3){ }}
     	车号作业接收完成
    {{#  } }}
	{{#  if(d.jobType == 4){ }}
     	防溜作业接收完成
    {{#  } }}	
	{{#  if(d.jobType == 5){ }}
     	列尾作业接收完成
    {{#  } }}
	{{#  if(d.jobType == 6){ }}
     	列检作业反馈完成
    {{#  } }}
	{{#  if(d.jobType == 7){ }}
     	商检作业反馈完成
    {{#  } }}
	{{#  if(d.jobType == 8){ }}
     	车号作业反馈完成
    {{#  } }}
	{{#  if(d.jobType == 9){ }}
     	防溜作业反馈完成
    {{#  } }}
	{{#  if(d.jobType == 10){ }}
     	列尾作业反馈完成
    {{#  } }}	
	</script>
    <script>
    
    $(document).ready(function(){
    	initTable();
    });
       
    function initTable(){
    	layui.use(['laypage','table'], function() {
            var laypage = layui.laypage
            ,table = layui.table //表格
          //执行一个 table 实例
            var tableIns = table.render({
              elem: '#resultTable'
              ,height: 500
              ,url: '${pageContext.request.contextPath }/jobFeedback/search' //数据接口
              ,page:{layout: ['count','prev', 'page', 'next']}
              ,limit:20
              ,cols: [[ //表头
                 /* {type:'checkbox'} */
                {field: 'id', title: 'ID', width:120}
                ,{field: 'trackName', title: '股道', width:150}
                ,{field: 'trainNumber', title: '车次', width:150}
                ,{field: 'postName', title: '反馈岗点', width:150}
                ,{field: 'jobType', title: '反馈内容', templet:'#jobTypeStr', width:150}
                ,{field: 'feedbackTime', title: '反馈时间', width:150}
                ,{fixed: 'right', width: 100, align:'center', toolbar: '#mytoolBar'}
              ]]
            });
            
           var active = {
          	      reload: function(){
          	      //执行重载
          	      	tableIns.reload({
              	        page: {
              	          curr: 1 //重新从第 1 页开始
              	        }
              	        ,where: {
              	        }
          	      	});
          	      }
            }
              
              $('#searchBtn').on('click', function(){
                  var type = $(this).data('type');
                  active[type] ? active[type].call(this) : '';
               });
            
          	//监听工具条
            table.on('tool(demo)', function(obj){ 
              //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
              var data = obj.data //获得当前行数据
              ,layEvent = obj.event; //获得 lay-event 对应的值
              if(obj.event === 'detail'){
            	//给当前页隐藏域赋值，供子页面获取
            	  layer.open({
            	        type: 2,
            	        skin: 'CLYM-style',
            	        area: ['600px','450px'],
            	        title: '',
            	        content: '${pageContext.request.contextPath }/jobFeedback/detail',
            	        success: function(layero, index){
            	            var body = layer.getChildFrame('body',index);//建立父子联系
            	            //给编辑子页面赋值
            	            body.find('input[name="trackName"]').val(data.trackName);
            	            body.find('input[name="trainNumber"]').val(data.trainNumber);
            	            body.find('input[name="postName"]').val(data.postName);
            	            body.find('input[name="jobType"]').val(data.jobType);
            	            body.find('input[name="feedbackTime"]').val(data.feedbackTime);
            	        }
            	    });
              } 
            });
     	})
    }
	
    </script>
  </body>

</html>


















