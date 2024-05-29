<%@ page language="java" pageEncoding="utf-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="include/pagetop.jsp"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="include/head.jsp"%>
</head>

<body>

	<%@ include file="include/loading.jsp"%>
	
	<div class="ifr-dody">
		<div class="ifr-con">
			<h3>永续合约管理</h3>
			
			<%@ include file="include/alert.jsp"%>
				
			<form action="<%=basePath%>normal/adminItemAction!list.action" method="post" id="queryForm">
				 <input type="hidden" name="pageNo" id="pageNo" value="${pageNo}" />
			</form>
			
			<div class="row">
				<div class="col-md-12 col-lg-12">
					<div class="panel panel-default">

						<div class="panel-title">
							修改永续合约
							<ul class="panel-tools">
								<li><a class="icon minimise-tool"><i class="fa fa-minus"></i></a></li>
								<li><a class="icon expand-tool"><i class="fa fa-expand"></i></a></li>
							</ul>
						</div>

						<div class="panel-body">
						
							<form class="form-horizontal" action="<%=basePath%>normal/adminItemAction!update.action" method="post" name="mainForm" id="mainForm">
								  
								<input type="hidden" name="id" id="id" value="${id}" />
								<h5>基础信息</h5>
								
								<div class="form-group">
									<label class="col-sm-2 control-label form-label">名称</label>
									<div class="col-sm-5">
										<input id="name" name="name" class="form-control " value="${name}"/>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label form-label">代码</label>
									<div class="col-sm-5">
									<input id="symbol" name="symbol" class="form-control " readonly="readonly" value="${symbol}"/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label form-label">保留精度</label>
									<div class="col-sm-2">
										<div class="input-group">
											<input id="decimals" name="decimals" class="form-control " value="${decimals}"/>
					                    	<div class="input-group-addon">位</div>
					                    </div>
				                    </div>
			                    </div>
			                    
							    <div class="form-group">
									<label class="col-sm-2 control-label form-label">交易对</label>
									<div class="col-sm-5">
										<input id="symbol_data" name="symbol_data" class="form-control " readonly="readonly" value="${symbol_data}"/>
									</div>
								</div>
								
								<h5>交易信息</h5>
								<p class="ballon color1">盈亏公式：(合约总金额 /每张金额)*(涨跌点数/最小变动单位*最小变动单位的盈亏金额)。</p>
								
								<div class="form-group">
									<label class="col-sm-2 control-label form-label">金额/张</label>
									<div class="col-sm-3">
									<input id="unit_amount" name="unit_amount" class="form-control " placeholder="合约每张金额" value="${unit_amount}"/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label form-label">手续费/张</label>
									<div class="col-sm-3">
									<input id="unit_fee" name="unit_fee" class="form-control " placeholder="合约每张金额" value="${unit_fee}"/>
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label form-label">最小变动单位</label>
									<div class="col-sm-3">
									<input id="pips" name="pips" class="form-control " placeholder="报价变动的最小幅度"/>
										<input type="hidden" id="pips_str" value="${pips}"/>
										<p>报价变动的最小幅度，行情低于设置单位不会计价盈亏"</p>
									</div>									
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label form-label">最小变动单位的盈亏金额</label>
									<div class="col-sm-3">
										<input id="pips_amount" name="pips_amount" class="form-control " placeholder="最小变动单位的盈亏金额" value="${pips_amount}"/>
									</div>
								</div>
								
								<div class="col-sm-1">
									<!-- 模态框（Modal） -->
									<div class="modal fade" id="modal_succeeded" tabindex="-1"
										role="dialog" aria-labelledby="myModalLabel"
										aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content" style="width: 350px;">
											
												<div class="modal-header">
													<button type="button" class="close"
														data-dismiss="modal" aria-hidden="true">&times;</button>
													<h4 class="modal-title" id="myModalLabel">登录人资金密码</h4>
												</div>
												
												<div class="modal-body">
													<div class="" >
														<input id="login_safeword" type="password" name="login_safeword"
															class="login_safeword" placeholder="请输入登录人资金密码" style="width: 250px;">
													</div>
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
								
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<a href="javascript:goUrl(${pageNo})" class="btn">取消</a> <a
											href="javascript:submit()"  class="btn btn-default">保存</a>
									</div>
								</div>

							</form>

						</div>

					</div>
				</div>
			</div>
		</div>

		<%@ include file="include/footer.jsp"%>

	</div>

	<%@ include file="include/js.jsp"%>
	
	<script type="text/javascript">
		function submit() {
			$('#modal_succeeded').modal("show");
		}
		$("#pips").val($("#pips_str").val());
	</script>
	
</body>

</html>
