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
  <link rel="stylesheet" href="${pageContext.request.contextPath }/css/layui.css">
  <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath }/js/xadmin.js"></script>
  <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
  <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  
<script type="text/javascript">
        $(document).ready(function(){
        	/* getThemeList(); */
        	initTable();
              //ajax请求后台数据
              /* getThemeList(); */
        });
        
        //ajax请求后台数据
        function getThemeList(){
        	var name = $("#themeName").val(); 
        	var module = $("#module").val();
        	var routeBegin = $("#routeBegin").val();
        	var routeEnd = $("#routeEnd").val();
            $.ajax({
                type:"post",
                async:false,
                cache:false,
                url:"${pageContext.request.contextPath }/theme/searchJson",
                data:{"name":name,"module":module,"routeBegin":routeBegin,"routeEnd":routeEnd},
                dataType:"json",
                success:function(data,status){
                    resolveThemeList(data.objects);
                    genPage(data.pageInfo);
                }
            });

        }

        function resolveThemeList(data){
            var s = "";
            $.each(data,function(v,o){
            		s+='<tr><td><div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id="2"><i class="layui-icon">&#xe605;</i></div></td>';
                    s+='<td>'+o.id+'</td>';
                    s+='<td>'+o.name+'</td>';
                    s+='<td>'+o.module+'</td>';
                    s+='<td>'+o.routeBegin+'</td>';
                    s+='<td>'+o.routeEnd+'</td>';
                    s+='<td class="td-manage">';
                    s+='<a title="编辑"  onclick="x_admin_show(\'编辑\',\'${pageContext.request.contextPath }/theme/toEdit?id=' + o.id + '\',600,450)" href="javascript:;">';
                    s+='<i class="layui-icon">&#xe642;</i></a>';
                    s+='<a title="删除" onclick="member_del(this,\'要删除的id\')" href="javascript:;">';
                    s+='<i class="layui-icon">&#xe640;</i></a>';
                    s+='</td></tr>'
            });
           if(data.length>0){
				$("tbody").html(s);
            }else{
                $("#page").hide();
                $("tbody").html("<tr><span style='width:10%;height:30px;display:block;margin:0 auto;'>暂无数据</span></tr>");
            }
        }



        function initTable(){
        	layui.use(['laypage','table'], function() {
                var laypage = layui.laypage
                ,table = layui.table //表格
               
                
              //执行一个 table 实例
                var tableIns = table.render({
                  elem: '#resultTable'
                  ,height: 500
                  ,url: '${pageContext.request.contextPath }/theme/searchJson' //数据接口
                  /* ,page: {layout: [ 'prev', 'page', 'next'] } //开启分页 */
                   ,page:{layout: ['prev', 'page', 'next']}
                  ,limit:10
                  ,cols: [[ //表头
                     /* {type:'checkbox'} */
                    {field: 'id', title: 'ID', width:100}
                    ,{field: 'name', title: '主题名', width:200}
                    ,{field: 'module', title: '所属模块', width:200}
                    ,{field: 'updateTime', title: '更新时间', width:300}
                    ,{field: 'routeBegin', title: '路线起点', width:300} 
                    ,{field: 'routeEnd', title: '路线终点', width: 300}
                    ,{fixed: 'right', width: 200, align:'center', toolbar: '#barDemo'}
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
	              	        	name: $("#themeName").val(),
	              	        	module:$("#module").val(),
	              	        	routeBegin:$("#routeBegin").val(),
	              	        	routeEnd:$("#routeEnd").val(),
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
                  	/* layer.msg('ID：'+ data.id + ' 的查看操作'); */
                  	if(data.module == 'index'){
	                    x_admin_show('定制主题','${pageContext.request.contextPath }/resources/wifiIndex?id='+data.id,900,600);
                  	}else if(data.module == 'video'){
                  		x_admin_show('定制主题','${pageContext.request.contextPath }/resources/video?id='+data.id,900,600);
                  	}else if(data.module == 'banner'){
                  		x_admin_show('定制主题','${pageContext.request.contextPath }/resources/banner?id='+data.id,900,600);
                  	}else if(data.module == 'portal'){
                  		x_admin_show('定制主题','${pageContext.request.contextPath }/resources/portal?id='+data.id,900,600);
                  	}else{
                  		//TODO:
                  	}
                  } else if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                    	$.ajax({
                            type:"post",
                            async:false,
                            cache:false,
                            url:"${pageContext.request.contextPath }/theme/delete",
                            data:{"id":data.id},
                            dataType:"json",
                            success:function(data,status){
			                      obj.del();
			                      layer.close(index);
                            }
                        });
                    });
                  } else if(obj.event === 'edit'){
                	  //给当前页隐藏域赋值，供子页面获取
                	  $("#selectVal").val(data.module);
                	  layer.open({
                	        type: 2,
                	        skin: 'CLYM-style',
                	        area: ['600px','450px'],
                	        title: '编辑主题信息',
                	        content: '${pageContext.request.contextPath }/theme/toEdit',
                	        success: function(layero, index){
                	            var body = layer.getChildFrame('body',index);//建立父子联系
                	            /* var iframeWin = window[layero.find('iframe')[0]['name']]; */
                	            // console.log(arr); //得到iframe页的body内容
                	            // console.log(body.find('input'));
                	            //给编辑子页面赋值
                	            body.find('input[name="id"]').val(data.id);
                	            body.find('input[name="name"]').val(data.name);
                	            body.find('input[name="routeBegin"]').val(data.routeBegin);
                	            body.find('input[name="routeEnd"]').val(data.routeEnd);
                	        }
                	    });
                	  /* x_admin_show('编辑主题信息','${pageContext.request.contextPath }/theme/toEdit',600,450) */
                     /*  layer.alert('编辑行：<br>'+ JSON.stringify(data)) */
                  }
                });
         	})
        }

</script>
</head>
  
  <body>
  	<input type="hidden" id="selectVal" value="index"/>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">主题定制</a>
        <a>
          <cite>主题管理</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
          <input type="text" id="themeName" name="name"  placeholder="主题名" autocomplete="off" class="layui-input"/>
          <input type="text" id="module" name="module"  placeholder="所属模块" autocomplete="off" class="layui-input"/>
          <input type="text" id="routeBegin" name="routeBegin"  placeholder="路线起点" autocomplete="off" class="layui-input"/>
          <input type="text" id="routeEnd" name="routeEnd"  placeholder="路线终点" autocomplete="off" class="layui-input"/>
          
          <button class="layui-btn" data-type="reload" type="button" id="searchBtn" ><i class="layui-icon">&#xe615;</i></button>
        </form>
      </div>
      <xblock>
        <!-- <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button> -->
        <button class="layui-btn" onclick="x_admin_show('添加主题','${pageContext.request.contextPath }/theme/toAdd',600,450)"><i class="layui-icon"></i>添加</button>
        <!-- <span class="x-right" style="line-height:40px">共有数据：<span id="count"></span> 条</span> -->
      </xblock>
      
      <%-- <table class="layui-table" lay-data="{width: 100%, height:332, url:'${pageContext.request.contextPath }/theme/searchJson/', page:true, id:'idTest'}" lay-filter="demo">
		  <thead>
		    <tr>
		      <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
		      <th lay-data="{field:'id', width:80, sort: true, fixed: true}">ID</th>
		      <th lay-data="{field:'name', width:80}">主题名</th>
		      <th lay-data="{field:'module', width:80, sort: true}">所属模块</th>
		      <th lay-data="{field:'routeBegin', width:80}">路线起点</th>
		      <th lay-data="{field:'routeEnd', width:160}">路线终点</th>
		      <th lay-data="{field:'score', width:80, sort: true, fixed: 'right'}">评分</th>
		      <th lay-data="{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}"></th>
		    </tr>
		  </thead>
	 </table> --%>
 
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail" title="查看"><i class='layui-icon'>&#xe64c;</i></a>
  <a class="layui-btn layui-btn-xs" lay-event="edit"><i class='layui-icon' title="编辑">&#xe642;</i></a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" title="删除"><i class='layui-icon'>&#xe640;</i></a>
</script>
      
      <table id="resultTable" class="layui-hide" lay-data="{id:resultTable}" lay-filter="demo">
      </table>
      <div id="page" class="page">
       
      </div>

    </div>
    <script>
    /* layui.use('table', function(){
      var table = layui.table;
      //监听表格复选框选择
      table.on('checkbox(demo)', function(obj){
        console.log(obj)
      });
      //监听工具条
      table.on('tool(demo)', function(obj){
        var data = obj.data;
        if(obj.event === 'detail'){
          layer.msg('ID：'+ data.id + ' 的查看操作');
          
        } else if(obj.event === 'del'){
          layer.confirm('真的删除行么', function(index){
            obj.del();
            layer.close(index);
          });
        } else if(obj.event === 'edit'){
          layer.alert('编辑行：<br>'+ JSON.stringify(data))
        }
      });
      
      var $ = layui.$, active = {
        getCheckData: function(){ //获取选中数据
          var checkStatus = table.checkStatus('idTest')
          ,data = checkStatus.data;
          layer.alert(JSON.stringify(data));
        }
        ,getCheckLength: function(){ //获取选中数目
          var checkStatus = table.checkStatus('idTest')
          ,data = checkStatus.data;
          layer.msg('选中了：'+ data.length + ' 个');
        }
        ,isAll: function(){ //验证是否全选
          var checkStatus = table.checkStatus('idTest');
          layer.msg(checkStatus.isAll ? '全选': '未全选')
        }
      };
      
      $('.demoTable .layui-btn').on('click', function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
      });
    }); */


      /*用户-删除*/
      function member_del(obj,id){
          layer.confirm('确认要删除吗？',function(index){
              //发异步删除数据
              $(obj).parents("tr").remove();
              layer.msg('已删除!',{icon:1,time:1000});
          });
      }



      function delAll (argument) {
        var data = tableCheck.getData();
        layer.confirm('确认要删除吗？'+data,function(index){
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
      }
    </script>
  </body>

</html>