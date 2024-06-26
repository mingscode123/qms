<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>월별 생산실적조회</title>
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
						<td>
						<td style="text-align: right;" colspan="2">
							<label for="productYear" class="col-form-label">계획년월</label>
						<td>
							<select class="form-control" id="productYear" name="productYear" style="text-align: center; -moz-text-align-last: center; text-align-last: center;">
								<option value=''>==년==</option>
							</select>
						</td>
						<td>
							<select class="form-control" id="productMonth" name="productMonth" style="text-align: center; -moz-text-align-last: center; text-align-last: center;">
								<option value=''>==월==</option>
								<option value='01'>01</option>
								<option value='02'>02</option>
								<option value='03'>03</option>
								<option value='04'>04</option>
								<option value='05'>05</option>
								<option value='06'>06</option>
								<option value='07'>07</option>
								<option value='08'>08</option>
								<option value='09'>09</option>
								<option value='10'>10</option>
								<option value='11'>11</option>
								<option value='12'>12</option>
							</select>
						</td>

						<td style="text-align: right;" colspan="2">
							<label for="compName" class="col-form-label">거래처</label>
						</td>
						<td>
							<div style="position: relative;">
								<input type="text" class="form-control" id="compName" name="compName" style="padding-right: 30px;"> <i class="ri-search-2-line" onclick="searchManage(0,'page')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i> <input type="hidden" id="compCd" name="compCd">
							</div>
						</td>

						<td colspan="3" style="text-align: left;">
							<button type="button" class="btn btn-info" onclick="monthProSearch();">조회</button>
							<button type="button" class="btn btn-success" id="downloadBtn">엑셀 다운로드</button>
						</td>
					</tr>
				</table>
			</form>
			<div class="card">
				<div class="card-body">
					<!-- Table with hoverable rows -->
					<table class="table table-hover" id="listTable">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">거래처명</th>
								<th scope="row">품번</th>
								<th scope="col">품명</th>
								<th scope="col">주문수량</th>
								<th scope="col">계획수량</th>
								<th scope="col">생산수량</th>
							</tr>
						</thead>
						<tbody>

						</tbody>

					</table>

					<!-- End Table with hoverable rows -->

					<nav aria-label="Page navigation example">
						<ul class="pagination" id="productPaging">

						</ul>
					</nav>

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
		$(document).ready(
				function() {
					var select = $("#productYear");
					var currentYear = new Date().getFullYear();

					for (var i = 0; i <= 2; i++) {
						var year = currentYear + i;
						select.append("<option value='" + year + "'>" + year
								+ "</option>");
					}
				});
		function searchManage(no, where) { //거래처 팝업창 띄우기
			w = where;
			row = no;

			var option = "width = 1000, height = 700, top = 100, left = 200"
			window.open('/receive/rcv01pop1', 'popup', option);
		}
		function receivePartnerData(rcvData) { // 거래처 인풋에 입력
			$('#compName').val(rcvData.compName);
			$('#compCd').val(rcvData.compCd);

		}

		var vaild = false;
		function monthProSearch(pno) {
			var productYear = $('#productYear').val();
			var productMonth = $('#productMonth').val();

			if (productYear != '' && productMonth != '') {
				if (pno == undefined) {
					$('#currentPage').val(1);
				} else {
					$('#currentPage').val(pno);
				}
				call_server(searchform, '/product/getMonthProSearch',
						getMonthProSearch);
			} else {
				alert("계획년월을 입력하세요.");
			}
		}

		function getMonthProSearch(vo) {
			list = vo.proList;
			$('#listTable > tbody').empty();
			for (var i = 0; i < list.length; i++) {
				$('#itCd').val(list[i].itemCd);
				$('#itName').val(list[i].itemName);
				str = "<tr>"
				str += "<th scope=\"row\">"
						+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
						+ "</th>";
				str += "<td>" + list[i].compName + "</td>";
				str += "<td>" + list[i].itemCd + "</td>";
				str += "<td>" + list[i].itemName + "</td>";
				str += "<td>" + list[i].orderQty + "</td>";
				str += "<td>" + list[i].planQty + "</td>";
				str += "<td>" + list[i].productQty + "</td>";
				str += "</tr>";
				$('#listTable > tbody').append(str);
			}
			setPaging(productPaging, vo.startPage, vo.endPage, 'monthProSearch');
		}
		
		$(document).ready(function() {
		    $('#downloadBtn').click(function() {
		    	excelDownload(searchform, '/product/monthProexcelDownload', 'monthPro_data.xlsx');
		    });
		}); //엑셀 다운로드 함수 

		
	</script>