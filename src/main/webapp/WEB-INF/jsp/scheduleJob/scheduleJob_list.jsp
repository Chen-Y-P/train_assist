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
  	<input type="hidden" id="selectPostId" value=""/>
  	<input type="hidden" id="selectDeptId" value=""/>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a>
          <cite>作业调度</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
    
      <div class="layui-row" align="center">
	      <div class="layui-form-item">
		    <div class="layui-inline">
     			<input type="text" id="arriveTime" name="arriveTime" placeholder="作业日期" autocomplete="off" class="layui-input">
		    </div>
		    <div class="layui-inline">
	            <div class="layui-input-inline"> 
	              	  <select id=isArrive name="isArrive" lay-search="">
			           <option value="">请选择出发/到达</option>
			           <option value="0">出发</option>
			           <option value="1">到达</option>
			          </select>
	             </div>
		    </div>
		    <div class="layui-inline">
          		<div class="layui-input-inline">
	              	  <select id="jobStatus" name="jobStatus" lay-search="">
			           <option value="">请选择作业状态</option>
			           <option value="0">进行中</option>
			           <option value="1">已完成</option>
			          </select>
	            </div>
		    </div>
		    <!-- <div class="layui-inline">
          		<input type="text" name="status"    placeholder="状态" autocomplete="off" class="layui-input">
		    </div> -->
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
	<script type="text/html" id="isArriveStr">
    {{#  if(d.isArrive == 1){ }}
     	到达
    {{#  } else { }}
                     出发
    {{#  } }}	
	</script>
	<script type="text/html" id="jobStatusStr">
    {{#  if(d.jobStatus == 1){ }}
     	已完成
    {{#  }}}
    {{#  if(d.jobStatus == 2){ }}
     	未开始
    {{#  }}}
	{{#  if(d.jobStatus == 0){ }}
     	进行中
    {{#  }}}	
	</script>
    <script>
    $(document).ready(function(){
    	initTable();
    });
       
    
    function initTable(){
    	layui.use(['laypage','table','laydate'], function() {
    		
            var laypage = layui.laypage
            ,table = layui.table //表格
            ,laydate = layui.laydate
          //执行一个laydate实例
            laydate.render({
              elem: '#arriveTime', //指定元素
              //type: 'date'
			  format: 'yyyy-MM-dd'
            });
          //执行一个 table 实例
            var tableIns = table.render({
              elem: '#resultTable'
              ,height: 500
              ,url: '${pageContext.request.contextPath }/scheduleJob/search' //数据接口
              ,page:{layout: ['count','prev', 'page', 'next']}
              ,limit:20
              ,cols: [[ //表头
                 /* {type:'checkbox'} */
                {field: 'arriveTime', title: '日期', width:120}
                ,{field: 'isArrive', title: '到达/出发', width:100,templet:'#isArriveStr'}
                ,{field: 'trackName', title: '股道', width:100}
                ,{field: 'trainCount', title: '辆数', width:100}
                ,{field: 'trainNumber', title: '车次', width:100}
                ,{field: 'jobStatus', title: '作业状态', width:100, templet:'#jobStatusStr'}
                ,{field: 'trainInspectTime', title: '通知列检作业时分', width:150}
                ,{field: 'tFinishTime', title: '列检作业完了时分', width:150}
                ,{field: 'goodsInspectTime', title: '通知商检作业时分', width:150}
                ,{field: 'gFinishTime', title: '商检作业完了时分', width:150}
                ,{field: 'trainNumTime', title: '通知车号作业时分', width:150}
                ,{field: 'antiRunningTime', title: '通知防溜作业时分', width:150}
                ,{field: 'antiRunningCount', title: '防溜/撤除防溜位数', width:150}
                ,{field: 'antiRunningMethod', title: '防溜方法', width:150}
                ,{field: 'antiRunningMan', title: '通知防溜人员', width:150}
                ,{field: 'trainTailTime', title: '通知列尾作业时分', width:150}
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
              	        	arriveTime:$("#arriveTime").val() + ' 00:00:00',
              	        		//new Date($("#arriveTime").val()).format("yyyy-MM-dd hh:mm:ss"),
              	        	isArrive:$("#isArrive").val(),
              	        	jobStatus:$("#jobStatus").val(),
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
            	  layer.open({
          	        type: 2,
          	        skin: 'CLYM-style',
          	        area: ['800px','600px'],
          	        title: '',
          	        content: '${pageContext.request.contextPath }/scheduleJob/detail?id='+data.id,
          	        success: function(layero, index){
          	           //
	          	        }
	          	    });
              } else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                	$.ajax({
                        type:"post",
                        async:false,
                        cache:false,
                        url:"${pageContext.request.contextPath }/user/delete",
                        data:{"id":data.id},
                        dataType:"json",
                        success:function(data,status){
	                          //刷新父窗口
	    					  //window.parent.location.reload();
		                      obj.del();
		                      layer.close(index);
                        }
                    });
                });
              } else if(obj.event === 'edit'){
            	  //给当前页隐藏域赋值，供子页面获取
            	  $("#selectDeptId").val(data.deptId);
            	  $("#selectPostId").val(data.postId);
            	  layer.open({
            	        type: 2,
            	        skin: 'CLYM-style',
            	        area: ['600px','450px'],
            	        title: '用户信息修改',
            	        content: '${pageContext.request.contextPath }/user/toEdit',
            	        success: function(layero, index){
            	            var body = layer.getChildFrame('body',index);//建立父子联系
            	            /* var iframeWin = window[layero.find('iframe')[0]['name']]; */
            	            // console.log(arr); //得到iframe页的body内容
            	            // console.log(body.find('input'));
            	            //给编辑子页面赋值
            	            body.find('input[name="id"]').val(data.id);
            	            body.find('input[name="userName"]').val(data.userName);
            	            body.find('input[name="password"]').val(data.password);
            	            body.find('input[name="aliases"]').val(data.aliases);
            	        }
            	    });
              }
            });
     	})
    }
	
    </script>
  </body>

</html>


















