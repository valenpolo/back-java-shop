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
			<h3>用户操作日志</h3>
			<%@ include file="include/alert.jsp"%>
			<!-- //////////////////////////////////////////////////////////////////////////// -->
			<!-- START queryForm -->
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">

						<div class="panel-title">查询条件</div>
						<div class="panel-body">

							<form class="form-horizontal"
								action="<%=basePath%>normal/adminLogAction!list.action"
								method="post" id="queryForm">
								<input type="hidden" name="pageNo" id="pageNo"
									value="${param.pageNo}">
									<!-- 
									<div class="col-md-12 col-lg-6" >
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<div class="input-prepend input-group">
                         <span class="add-on input-group-addon"><i class="fa fa-calendar"></i></span>
                         <s:textfield id="date_para" name="date_para"
													cssClass="form-control " placeholder="变更日期" />
                       </div>
											</div>
											
										</div>
									</fieldset>
								</div>
								 -->
								 
								<div class="col-md-12 col-lg-4" >
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<s:textfield id="name_para" name="name_para"
													cssClass="form-control " placeholder="用户名" />
											</div>
										</div>
									</fieldset>
								</div>
								<div class="col-md-12 col-lg-6">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<s:textfield id="log_para" name="log_para"
													cssClass="form-control " placeholder="日志" />
											</div>
										</div>
									</fieldset>
								</div>
								
								
								<div class="col-md-12 col-lg-3" style="margin-top: 10px;">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<s:textfield id="operator" name="operator"
													cssClass="form-control " placeholder="操作者" />
											</div>
										</div>
									</fieldset>
								</div>
								
								
								<div class="col-md-12 col-lg-3" style="margin-top: 10px;">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												
										<s:select id="category" cssClass="form-control " headerValue="分类"  headerKey=""
											name="category" list="category_map"
											listKey="key" listValue="value" value="category" />
											</div>
										</div>
									</fieldset>
								</div>
								<div class="col-md-12 col-lg-2" style="margin-top: 10px;">
									<button type="submit" class="btn btn-light btn-block">查询</button>
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
						<div class="panel-body">
							<table class="table table-bordered table-striped">
								<thead>

									<tr>

									<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_ROOT,ROLE_ADMINGUEST,ROLE_FINANCE,ROLE_DEBUG">
										<!--  <td>名称</td>-->
										<td>用户名</td>
										</sec:authorize>

										<td>日志</td>
										<td>操作者</td>
										<td width="150px">时间</td>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="page.elements" status="stat">
										<tr>

										<!-- 	<td><s:property value="name" /></td>-->

											<td><s:property value="username" /></td>
											<td><s:property value="log" /></td>
											<td><s:property value="operator" /></td>
											<td><s:date name="createTime" format="yyyy-MM-dd HH:mm " /></td>
										
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
	<script type="text/javascript">
$(document).ready(function() {
  $('#date_para').daterangepicker({
		timePicker : true, //显示时间
		timePicker24Hour : true, //时间制
		timePickerSeconds : true, //时间显示到秒
		format : 'YYYY-MM-DD HH:mm:ss',
		startDate : new Date(),
		endDate : new Date(),
		minDate : 1999 - 12 - 12,
		maxDate : 2050 - 12 - 30,
		timePicker : true,
		timePickerIncrement : 1,

		locale : {
			applyLabel : "确认",
			cancelLabel : "取消",
			resetLabel : "重置",

		}
	}, function(start, end, label) {
    console.log(start.toISOString(), end.toISOString(), label);
  });
});
</script>
</body>
</html>