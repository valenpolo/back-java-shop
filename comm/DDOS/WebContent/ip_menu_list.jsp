<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="include/pagetop.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp"%>
</head>
<body>
	<%@ include file="include/loading.jsp"%>
	<%@ include file="include/top.jsp"%>
	<%@ include file="include/menu_left.jsp"%>

	<!-- //////////////////////////////////////////////////////////////////////////// -->
	<!-- START CONTENT -->
	<div class="content">



		<!-- //////////////////////////////////////////////////////////////////////////// -->
		<!-- START CONTAINER -->
		<div class="container-default">
			<h3>IP名单管理
				(<s:if test="type_para=='white'">白名单</s:if>
				<s:if test="type_para=='black'">黑名单</s:if>
				<s:if test="type_para=='lock'">锁定名单</s:if>
				)
			</h3>
				<%@ include file="include/alert.jsp"%>
			<!-- //////////////////////////////////////////////////////////////////////////// -->
			<!-- START queryForm -->
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">

						<div class="panel-title">查询条件</div>
						<div class="panel-body">

							<form class="form-horizontal" action="<%=basePath%>normal/adminIpMenuAction!list.action" method="post"
								id="queryForm">
								<input type="hidden" name="pageNo" id="pageNo"
									value="${param.pageNo}">
								<input type="hidden" name="type_para" id="type_para">
								<div class="col-md-12 col-lg-4">
									<fieldset>
										<div class="control-group">
											<div class="controls">
													<s:textfield id="ip_para" name="ip_para" cssClass="form-control " placeholder="ip"/>
											</div>
										</div>
										
									</fieldset>
								</div>
								<%-- <div class="col-md-12 col-lg-4">
										<fieldset>
											<div class="control-group">
												<div class="controls">
													<s:select id="type_para" cssClass="form-control "
														name="type_para"
														list="#{'black':'黑名单','white':'白名单'}" listKey="key"
														listValue="value" headerKey="" headerValue="所有名单"
														value="type_para" />
												</div>
											</div>
										</fieldset>
								</div> --%>

								<div class="col-md-12 col-lg-2">
									<button type="submit" class="btn btn-light btn-block">查询</button>
								</div>
								<div class="col-md-12 col-lg-12" style="margin-top: 10px;">
									<div class="mailbox clearfix">
										<div class="mailbox-menu">
											<ul class="menu">
												<li><a href="javascript:setType('white')"> 白名单</a></li>
												<li><a href="javascript:setType('black')">黑名单</a></li>
												<li><a href="javascript:setType('lock')">锁定名单</a></li>
<!-- 												<li><a href="javascript:setState('2')">违约</a></li> -->


											</ul>
										</div>
									</div>
								</div>

							</form>

						</div>

					</div>
				</div>
			</div>
			<!-- END queryForm -->
			<!-- //////////////////////////////////////////////////////////////////////////// -->
			
			
			<div class="row">
            <div class="col-md-12">
                <!-- Start Panel -->
                <div class="panel panel-default">

                    <div class="panel-title">查询结果</div>
                    <a href="<%=basePath%>normal/adminIpMenuAction!toAdd.action?ip_para=<s:property value="ip_para" />&type_para=<s:property value="type_para" />" class="btn btn-light" style="margin-bottom: 10px" ><i class="fa fa-pencil"></i>新增IP名单</a>
                    <div class="panel-body">
                        <table class="table table-bordered table-striped">
                            <thead>

                            <tr>
                                <td>ip</td>
                                <td>类型</td>
                                <td>请求次数</td>
                                <td>处理时间</td>
                                <td style="width:130px;"></td>
                            </tr>
                            </thead>
                            <tbody>
                            <s:iterator value="page.elements" status="stat">
                                <tr>
                                    <td><a href="#" onClick="getUrlsCount('<s:property value="ip" />')"><s:property value="ip" /></a></td>
                                    <td>
										<s:if test='type=="black"'>
												<span class="right label label-danger">黑名单</span>
											</s:if>  
										<s:if test='type=="white"'>
												<span class="right label label-success">白名单</span>
											</s:if> 
										<s:if test='type=="lock"'>
												<span class="right label label-warning">锁定名单</span>
											</s:if> 
										</td>
									<td><s:property value="count" /></td>
                                    <td><s:date name="last_opera_time" format="yyyy-MM-dd HH:mm" /></td>
                                    <td>
                                        <div class="btn-group">
						                    <button type="button" class="btn btn-light">操作</button>
						                    <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
						                      <span class="caret"></span>
						                      <span class="sr-only">Toggle Dropdown</span>
						                    </button>
						                    <ul class="dropdown-menu" role="menu">
<%-- 						                     		<li><a href="<%=basePath%>normal/adminIpMenuAction!toUpdate.action?menu_ip=<s:property value="ip" />">修改</a></li> --%>
						                       		 <li><a href="javascript:del('<s:property value="ip" />')">删除</a></li>
						                      	 </ul>
						                </div>
						              
                                    </td>

                                </tr>
                            </s:iterator>

                            </tbody>
                        </table>
                        <%@ include file="include/page_simple.jsp"%>
                       <nav>
          
                    </div>

                </div>
                <!-- End Panel -->

            </div>
        </div>
			
		</div>
		<!-- END CONTAINER -->
		<!-- //////////////////////////////////////////////////////////////////////////// -->


		<%@ include file="include/footer.jsp"%>


	</div>
	<!-- End Content -->
	<!-- //////////////////////////////////////////////////////////////////////////// -->



<%@ include file="include/js.jsp"%>
<form
	action="<%=basePath%>normal/adminIpMenuAction!toDelete.action"
	method="post" id="succeededForm">
	<s:hidden name="menu_ip" id="menu_ip"></s:hidden>
	<s:hidden name="type_para"></s:hidden>
	<s:hidden name="ip_para"></s:hidden>
<%-- 	<s:hidden name="query_symbol" id="query_symbol"></s:hidden> --%>
	<div class="col-sm-1">
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="modal_succeeded" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" >
					<div class="modal-header">
						<button type="button" class="close"
							data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">确认删除</h4>
					</div>
					<div class="modal-body">
						<div class="form-group" >
							<label for="input002" class="col-sm-3 control-label form-label">登录人资金密码</label>
							<div class="col-sm-4">
								<input id="login_safeword" type="password" name="login_safeword"
									class="login_safeword" placeholder="请输入登录人资金密码" >
							</div>
						</div>
						<!-- <div class="form-group" style="">
						
							<label for="input002" class="col-sm-3 control-label form-label">验证码</label>
							<div class="col-sm-4">
								<input id="email_code" type="text" name="email_code"
								class="login_safeword" placeholder="请输入验证码" >
							</div>
							<div class="col-sm-4">
								<button id="email_code_button" 
										class="btn btn-light " onClick="sendCode();" >获取验证码</button>
								<a id="email_code_button" href="javascript:sendCode();" class="btn btn-light" style="margin-bottom: 10px" >获取超级签验证码</a>
							</div>
						</div> -->
						<!-- <div class="form-group" >
							<label for="input002" class="col-sm-3 control-label form-label">超级谷歌验证码</label>
							<div class="col-sm-4">
								<input id="super_google_auth_code"  name="super_google_auth_code"
									 placeholder="请输入超级谷歌验证码" >
							</div>
						</div> -->
					</div>
					<div class="modal-footer" style="margin-top: 0;">
						<button type="button" class="btn "
							data-dismiss="modal">关闭</button>
						<button id="sub" type="submit"
							class="btn btn-default" >确认</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</div>
</form>
<div class="form-group">
		<div class="col-sm-1">
				<!-- 模态框（Modal） -->
				<div class="modal fade" id="urls_form" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel"
					aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close"
									data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">urls请求数详情</h4>
							</div>
							<div class="modal-body" style="max-height: 400px;overflow-y: scroll;">
							<table class="table table-bordered table-striped" >
								<thead>
									<tr>
										<td>url</td>
										<td>请求数</td>
									</tr>
								</thead>
								<tbody id="modal_urls_table">
									<%@ include file="include/loading.jsp"%>
								</tbody>
							</table>
							</div>
							
							<!-- <div class="modal-footer" style="margin-top: 0;">
								<button type="button" class="btn "
									data-dismiss="modal">关闭</button>
									<button id="sub" type="submit" class="btn btn-default" >保存</button>
																			
							</div> -->
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal -->
				</div>
			</div>
	</div>

<script type="text/javascript">
	function del(ip) {
		
		$("#menu_ip").val(ip);
// 		$("#query_symbol").val(symbol);
		$('#modal_succeeded').modal("show");
	};
</script>
<script type="text/javascript">
		function setType(type_para){
    		document.getElementById("type_para").value=type_para;
    		document.getElementById("queryForm").submit();
		}
	</script>
<script type="text/javascript">
function getUrlsCount(ip){
	$("#urls_form").modal("show");
	
	var url = "<%=basePath%>normal/adminIpCountAction!getUrlsCount.action";
	var data = {"menu_ip":ip};
	goNewAjaxUrl(url,data,function(tmp){
		var str='';
		var content='';
		for(var i=0;i<tmp.urls_count.length;i++){
			str += '<tr>'
				+'<td>'+tmp.urls_count[i].url+'</td>'
				+'<td>'+tmp.urls_count[i].count+'</td>'
				+'</tr>';
		}
		$("#modal_urls_table").html(str);
		
	},function(){
//			$("#coin_value").val(0);
	});
}

function goNewAjaxUrl(targetUrl,data,Func,Fail){
//		console.log(data);
	$.ajax({
		url:targetUrl,
		data:data,
		type : 'get',
		dataType : "json",
		success: function (res) {
			var tmp = $.parseJSON(res)
			console.log(tmp);
		    if(tmp.code==200){
		    	Func(tmp);
		    }else if(tmp.code==500){
		    	Fail();
		    	swal({
					title : tmp.message,
					text : "",
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "确认",
					closeOnConfirm : false
				});
		    }
		  },
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
				swal({
					title : "请求错误",
					text : "",
					type : "warning",
					showCancelButton : true,
					confirmButtonColor : "#DD6B55",
					confirmButtonText : "确认",
					closeOnConfirm : false
				});
				console.log("请求错误");
			}
	});
}
</script>
</body>
</html>