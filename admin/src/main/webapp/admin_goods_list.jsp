<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="security" class="security.web.BaseSecurityAction" scope="page" />

<%@ include file="include/pagetop.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp"%>
</head>
<body>
	<%@ include file="include/loading.jsp"%>
<%-- 	<%@ include file="include/top.jsp"%> --%>
<%-- 	<%@ include file="include/menu_left.jsp"%> --%>

	<!-- //////////////////////////////////////////////////////////////////////////// -->
	<!-- START CONTENT -->
	<div class="ifr-dody">

		<!-- //////////////////////////////////////////////////////////////////////////// -->
		<!-- START CONTAINER -->
		<div class="ifr-con">
			<h3>商品列表</h3>
			<!-- //////////////////////////////////////////////////////////////////////////// -->
			<!-- START queryForm -->
			<%@ include file="include/alert.jsp"%>
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">

						<div class="panel-title">查询条件</div>

						<div class="panel-body">

							<form class="form-horizontal" action="<%=basePath%>/mall/goods/list.action" method="post"
								id="queryForm">
								<input type="hidden" name="pageNo" id="pageNo"
									value="${pageNo}">
								<div class="col-md-12 col-lg-4">
									<fieldset>
										<div class="control-group">
											<div class="controls">
											<input id="name" name="name" class="form-control"
											placeholder="商品名称" value = "${name}"/>
											</div>
										</div>
									</fieldset>
								</div>
								<div class="col-md-12 col-lg-3">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<input id="PName" name="PName" class="form-control"
													   placeholder="项目分类" value = "${PName}"/>
											</div>
										</div>
									</fieldset>
								</div>
								<div class="col-md-12 col-lg-2">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<select id="isShelf" name="isShelf"
														class="form-control ">
													<option value="-2">商品状态</option>
													<option value="1" <c:if test="${isShelf == '1'}">selected="true"</c:if>>上架</option>
													<option value="0" <c:if test="${isShelf == '0'}">selected="true"</c:if>>下架</option>
												</select>
											</div>
										</div>
									</fieldset>
								</div>
								<div class="col-md-12 col-lg-12" style="margin-top:10px;"></div>
								<div class="col-md-12 col-lg-2">
									<input id="startTime" name="startTime" class="form-control "
										   placeholder="开始日期" value="${startTime}" />
								</div>
								<div class="col-md-12 col-lg-2">

									<input id="endTime" name="endTime" class="form-control "
										   placeholder="结束日期" value="${endTime}" />
								</div>

								<div class="col-md-12 col-lg-2">
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

						<c:if test="${security.isRolesAccessible('ROLE_ROOT,ROLE_ADMIN')
									 || security.isResourceAccessible('OP_MALL_GOODS_OPERATE')}">
						
							<a href="<%=basePath%>/mall/goods/toAdd.action?pageNo=${pageNo}" class="btn btn-light" style="margin-bottom: 10px">
								<i class="fa fa-pencil"></i>新增商品</a>
								
						</c:if>

						<c:if test="${security.isRolesAccessible('ROLE_ROOT,ROLE_ADMIN')
									 || security.isResourceAccessible('OP_MALL_GOODS_OPERATE')}">


							<a href="javascript:award()"
							   class="btn btn-light" style="margin-bottom: 12px"><i
									class="fa fa-pencil"></i>导入链接</a>
						</c:if>
						
						<div class="panel-body">
								
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<td>商品名称</td>
										<td>商品分类</td>
										<td>价格</td>
										<td>是否上架</td>
										<td>排序</td>
										<td>最小购买数量</td>
										<td>创建时间</td>
										<td width="130px"></td>
									</tr>
								</thead>
								<tbody>
									<!-- <s:iterator value="page.elements" status="stat"> -->
									<c:forEach items="${page.getElements()}" var="item" varStatus="stat">
										<input type="hidden" name="iconImg" id="iconImg" value = "${item.iconImg}"/>
										<tr>
<%--											<td>--%>
<%--												<img width="90px" height="90px" id="show_img" src="<%=basePath%>normal/showImg.action?imagePath=${item.iconImg}"/> 　　--%>
<%--											</td>--%>

									<td style="width: 160px;">
										<div style="width:120px; margin-left: 20px; text-align: center; overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"  title="${item.name}">

												${item.name}
										</div></td>
									    <td>${item.PName}</td>
										<td> <fmt:formatNumber value="${item.systemPrice}" pattern="#0.00"/></td>
										<td>
											<c:choose>
												<c:when test="${item.isShelf == '1'}">
													<span class="right label label-success">上架</span>
												</c:when>
												<c:otherwise>
													<span class="right label label-danger">下架</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>${item.sort}</td>
										<td>${item.buyMin}</td>
										<td>${item.createTime}</td>
											<td>
												<c:if test="${security.isRolesAccessible('ROLE_ROOT,ROLE_ADMIN')
															|| security.isResourceAccessible('OP_MALL_GOODS_OPERATE')}">
											
													<div class="btn-group">
														<button type="button" class="btn btn-light">操作</button>
														<button type="button" class="btn btn-light dropdown-toggle"
															data-toggle="dropdown" aria-expanded="false">
															<span class="caret"></span> <span class="sr-only">Toggle Dropdown</span>
														</button>
														<ul class="dropdown-menu" role="menu">
														
															<li><a href="<%=basePath%>/mall/goods/toUpdate.action?lang=cn&goodsId=${item.id}">编辑</a></li>
															<li><a href="javascript:toDelete('${item.id}')">删除</a></li>
														</ul>
													</div>
												</c:if>
											</td>
											
										</tr>
										
									</c:forEach>

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
		
		<!-- 模态框 -->
		<div class="form-group">
			<form action=""
					method="post" id="mainform">
				<input type="hidden" name="pageNo" id="pageNo"
					   value="${pageNo}">
				<input type="hidden" name="id" id="id"/>
				<div class="col-sm-1 form-horizontal">
					<!-- 模态框（Modal） -->
					<div class="modal fade" id="modal_succeeded" tabindex="-1"
						 role="dialog" aria-labelledby="myModalLabel"
						 aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content" >
								<div class="modal-header">
									<button type="button" class="close"
											data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">确认调整</h4>
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
                                            <a id="update_email_code_button" href="javascript:updateSendCode();" class="btn btn-light" style="margin-bottom: 10px" >获取超级签验证码</a>
                                        </div>
                                    </div> -->
<%--									<div class="form-group" >--%>
<%--										<label for="input002" class="col-sm-3 control-label form-label">谷歌验证码</label>--%>
<%--										<div class="col-sm-4">--%>
<%--											<input id="google_auth_code"  name="google_auth_code"--%>
<%--												   placeholder="请输入谷歌验证码" >--%>
<%--										</div>--%>
<%--									</div>--%>
								</div>
								<div class="modal-footer" style="margin-top: 0;">
									<button type="button" class="btn "
											data-dismiss="modal">关闭</button>
									<button id="sub" type="submit"
											class="btn btn-default">确认</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal -->
					</div>
				</div>
			</form>
		</div>

		<div class="form-group">

			<form action="<%=basePath%>mall/goods/importUrl.action"
				  method="post" id="succeededForm">
				<div class="col-sm-1">
					<!-- 模态框（Modal） -->
					<div class="modal fade" id="modal_set"
						 tabindex="-1" role="dialog"
						 aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">

								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabels">商品分类</h4>

								</div>

								<div class="modal-body">
									<select id="categorys" name="categoryId" class="form-control">
									</select>
								</div>

								<div id="setting">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel2">商品链接</h4>
									</div>

									<div class="modal-body">
										<div class="" style="width: 97%;float: left;">
											<input id="url" name="url"
												   class="form-control"  value="${url}" placeholder="请输入商品链接">
										</div>
									</div>
								</div>


								<div class="modal-footer" style="margin-top: 0;">
									<button type="button" class="btn " data-dismiss="modal">关闭</button>
									<button id="sub" type="submit" class="btn btn-default">确认</button>
								</div>

							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal -->
					</div>
				</div>

			</form>

		</div>

		<%@ include file="include/footer.jsp"%>

	</div>
	<!-- End Content -->
	<!-- //////////////////////////////////////////////////////////////////////////// -->

	<%@ include file="include/js.jsp"%><script src="<%=basePath%>js/bootstrap/bootstrap-treeview.js"></script>
	<script>
	</script>


	<script type="text/javascript">
		<%--setTimeout(function() {--%>
		<%--	start();--%>
		<%--}, 100);--%>

		<%--function start(){--%>
		<%--	var img = $("#iconImg").val();--%>
		<%--	var show_img = document.getElementById('show_img');--%>
		<%--	show_img.src="<%=basePath%>normal/showImg.action?imagePath="+img;--%>
		<%--}--%>

		function toDelete(id,pageNo){
			$('#id').val(id);
			$('#pageNo').val(pageNo);
			$('#myModalLabel').html("删除");
			$('#mainform').attr("action","<%=basePath%>mall/goods/delete.action");

			$('#modal_succeeded').modal("show");

		}

		$(function() {
			$('#startTime').datetimepicker({
				format : 'yyyy-mm-dd hh:ii:00',
				minuteStep:1,
				language : 'zh',
				weekStart : 1,
				todayBtn : 1,
				autoclose : 1,
				todayHighlight : 1,
				startView : 2,
				clearBtn : true
			});
			$('#endTime').datetimepicker({
				format : 'yyyy-mm-dd hh:ii:00',
				minuteStep:1,
				language : 'zh',
				weekStart : 1,
				todayBtn : 1,
				autoclose : 1,
				todayHighlight : 1,
				startView : 2,
				clearBtn : true
			});

		});

		function award(){
			getCategoryList();
			$('#modal_set').modal("show");
		}

		function getCategoryList(){

			$.ajax({
				type: "get",
				url: "<%=basePath%>mall/category/findCategoryList.action",
				dataType : "json",
				data : {

				},
				success : function(data) {

					var tmp = data;
					var categoryList = tmp.categoryList;
					let optionString = "";

					for (var key in categoryList){
						optionString += "<option value=\"" + key  + "\">" + categoryList[key] + "</option>";
						// $("#categoryList").html(optionString);
						// console.log(categoryList[key] +'   '+key);
					}

					$("#categorys").html(optionString);
				},
				error : function(XMLHttpRequest, textStatus,
								 errorThrown) {
					console.log("请求错误");
				}
			});
		}
	</script>
</body>
</html>