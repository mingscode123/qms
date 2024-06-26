<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>소요자재조회</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="/assets/img/favicon.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="/assets/css/style.css" rel="stylesheet">

</head>

<body>

	<%@ include file="../layout/menu.jsp"%>

	<main id="main" class="main">

		<section class="section">
			<form id="searchform">
				<input type='hidden' id='currentPage' name='currentPage' value=1>
				<table class="table table-borderless">
					<tr>
						<td style="text-align: right;" colspan="2"><label for="palnDtFrom" class="col-form-label">계획일</label></td>
						<td><input type="date" class="form-control" id = "palnDtFrom" name="palnDtFrom"></td>
						<td style="text-align: center;">~</td>
						<td><input type="date" class="form-control" id = "palnDtTo" name="palnDtTo"></td>

						<td style="text-align: right;" colspan="2"><label for="compName" class="col-form-label">품번</label></td>
						<td><input type="text" class="form-control" name="itemCd"></td>

						<td style="text-align: right;" colspan="2"><label for="compCd" class="col-form-label">거래처</label></td>
						<td>
							<div style="position: relative;">
								<input type="text" class="form-control" id = "compName" name="compName" style="padding-right: 30px;"> <i class="ri-search-2-line" onclick="searchManage(0)" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
								<input type="hidden"id = "compCd" name="compCd">
							</div>
						</td>

						<td colspan="3" style="text-align: left;">
							<button type="button" class="btn btn-info" onclick="searchPlanItemList(1);">조회</button>
						</td>
					</tr>
				</table>
			</form>
			
			<div class="row">
			<div class="col-lg-6">
				<div class="card">
					<div class="card-body">
						<!-- 첫 번째 영역의 내용 -->
						<form id = "planItemform">
						<div style="display: flex; align-items: center; justify-content: space-between; margin-top: 20px;">
							<h5><strong>생산계획품목</strong></h5>
							<button type="button" class="btn btn-info" onclick="searchmaterialReqList(1);">수량확인</button>
						</div>
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="planItemTable" >
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">품번</th>
									<th scope="col">품명</th>
									<th scope="col">계획수량</th>
								</tr>
							</thead>
							<tbody>
								<!-- 테이블 내용 -->
							</tbody>
						</table>
						</form>
						<!-- End Table with hoverable rows -->
					</div>
				</div>
				<!-- 첫 번째 카드의 페이징 -->
				<nav aria-label="Page navigation example">
							<ul class="pagination" id="planItemPaging">
							</ul>
						</nav>
				<!-- End Pagination with icons -->
			</div>
			
			<div class="col-lg-6">
				<div class="card">
					<div class="card-body">
						<!-- 두 번째 영역의 내용 -->
						<div style="margin-top: 20px;">
							<h5><strong>BOM자재품목</strong></h5>
						</div>
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="materialReqTable" >
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">품번</th>
									<th scope="col">품명</th>
									<th scope="col">소요수량</th>
									<th scope="col">BOX수량</th>
								</tr>
							</thead>
							<tbody>
								<!-- 테이블 내용 -->
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
					</div>
				</div>
				<!-- 두 번째 카드의 페이징 -->
				<nav aria-label="Page navigation example">
							<ul class="pagination" id="materialReqPaging">
							</ul>
						</nav>
				<!-- End Pagination with icons -->
			</div>
		</div>

		</section>
	</main>
	<!-- End #main -->


	<!-- ======= Footer ======= -->
	<%@ include file="../layout/footer.jsp"%>




<script src="/assets/js/common.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/paging.js"></script>
<script>
//서치폼쪽 세팅
$(document).ready(function() {//디폴트 날짜세팅
    var today = new Date();
    var weekLater = new Date();
    weekLater.setDate(today.getDate() + 7);

    var todayStr = today.toISOString().split('T')[0];
    var weekLaterStr = weekLater.toISOString().split('T')[0];
	// input 요소에 값 설정
	$('#palnDtFrom').val(todayStr);
	$('#palnDtTo').val(weekLaterStr);
});

function searchManage(no) { //거래처 팝업창 띄우기
	row = no;
	var option = "width = 1000, height = 700, top = 100, left = 200"
	window.open('/receive/rcv01pop1', 'popup', option);
}
function receivePartnerData(rcvData) { // 거래처 인풋에 입력
		$('#compName').val(rcvData.compName);
		$('#compCd').val(rcvData.compCd);
}
function searchPlanItemList(pno){
	if (pno == undefined) {
		$('#currentPage').val(1);
	} else {
		$('#currentPage').val(pno);
	}
	$('#materialReqTable > tbody').empty();
	call_server(searchform, '/plan/getPlanItemList', getPlanItemList);
}
//planItemTable
function getPlanItemList(vo) {
	$('#planItemTable > tbody').empty();
	var list = vo.planlist;

	for (var i = 0; i < list.length; i++) {
		str = "<tr>";
		str += "<th scope=\"row\">"
				+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
				+ "</th>";
		str += "<td><input type='hidden' name='bomlist[" + i + "].itemCd' value='" + list[i].itemCd + "' >" + list[i].itemCd + "</td>";
		str += "<td>" + list[i].itemName + "</td>";
		str += "<td>" + list[i].totalPlanQty + "</td>";
		str += "</tr>";
		$('#planItemTable').append(str);
	}
	setPaging(planItemPaging, vo.startPage, vo.endPage, 'searchPlanItemList');
}
function searchmaterialReqList(pno){
	if (pno == undefined) {
		$('#currentPage').val(1);
	} else {
		$('#currentPage').val(pno);
	}
	call_server(planItemform, '/plan/getMaterialReqList', getMaterialReqList);
}
//materialReqTable
function getMaterialReqList(vo){
	$('#materialReqTable > tbody').empty();
	var list = vo.planlist;

	for (var i = 0; i < list.length; i++) {
		str = "<tr>";
		str += "<th scope=\"row\">"
				+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
				+ "</th>";
		str += "<td>" + list[i].sitemCd + "</td>";
		str += "<td>" + list[i].itemName + "</td>";
		str += "<td>" + list[i].demandQty + "</td>";
		str += "<td>" + list[i].boxQty + "</td>";
		str += "</tr>";
		$('#materialReqTable').append(str);
	}
	setPaging(materialReqPaging, vo.startPage, vo.endPage, 'searchmaterialReqList');
}
	
</script>
