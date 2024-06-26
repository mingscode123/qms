<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title><spring:message code="page.title" /></title>
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
						<td style="text-align: right;" colspan="2">
							<label for="deliDtFrom" class="col-form-label"><spring:message code="label.deliveryDate" /></label>
						</td>
						<td>
							<input type="date" class="form-control" name="deliveryDtFrom">
						</td>
						<td style="text-align: center;">~</td>
						<td>
							<input type="date" class="form-control" name="deliveryDtTo">
						</td>

						<td style="text-align: right;" colspan="2">
							<label for="compName" class="col-form-label"><spring:message code="label.itemCode" /></label>
						</td>
						<td>
							<input type="text" class="form-control" name="itemCd">
						</td>

						<td style="text-align: right;" colspan="2">
							<label for="compName" class="col-form-label"><spring:message code="label.customer" /></label>
						</td>
						<td>
							<div style="position: relative;">
								<input type="text" class="form-control" id="compName" name="compName" style="padding-right: 30px;"> <i class="ri-search-2-line" onclick="searchManage(0,'page')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i> <input type="hidden" id="compCd" name="compCd">
							</div>
						</td>

						<td colspan="3" style="text-align: left;">
							<button type="button" class="btn btn-info" onclick="orderSearch();"><spring:message code="button.search" /></button>
							<button type="button" class="btn btn-primary" onclick="displayModal('0','0','0','0');"><spring:message code="button.new" /></button>
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
								<th scope="col"><spring:message code="table.no" /></th>
								<th scope="col"><spring:message code="table.orderNumber" /></th>
								<th scope="col"><spring:message code="table.customerName" /></th>
								<th scope="col"><spring:message code="table.itemCode" /></th>
								<th scope="col"><spring:message code="table.itemName" /></th>
								<th scope="col"><spring:message code="table.itemPrice" /></th>
								<th scope="col"><spring:message code="table.saleQuantity" /></th>
								<th scope="col"><spring:message code="table.salePrice" /></th>
								<th scope="col"><spring:message code="table.status" /></th>
								<th scope="col"><spring:message code="table.deliveryDate" /></th>
								<th scope="col"><spring:message code="table.registrationDate" /></th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>

					<!-- End Table with hoverable rows -->
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="orderPaging">

						</ul>
					</nav>

				</div>
			</div>

		</section>
	</main>
	<!-- End #main -->


	<!-- ======= Footer ======= -->
	<%@ include file="../layout/footer.jsp"%>



</body>

<div class="modal fade" id="orderModal" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><spring:message code="modal.title" /></h5>
			</div>
			<div class="modal-body">
				<form id="modalform">
					<table class="table table-hover" id="productOrderingDetailTable">
						<thead>
							<tr>
								<td>
									<div style="display: flex; align-items: center; position: relative;">
										<label for="compCd" class="col-form-label" style="margin-right: 10px;"><spring:message code="modal.customerCode" /></label> <input type="text" class="form-control" id="mcompCd" name="compCd" style="width: 150px; margin-right: 10px;"> <i class="ri-search-2-line" onclick="searchManage(0,'modal')" style="position: absolute; left: 220px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i> <label for="" class="col-form-label" style="margin-left: 20px; margin-right: 10px;"><spring:message code="modal.deliveryDate" /></label> <input type="date" class="form-control" id="mdeliveryDt" name="deliveryDt" onchange="validateDeliveryDate();" style="margin-right: 10px; width: 150px;"> <label for="" class="col-form-label" style="margin-left: 20px; margin-right: 10px;"><spring:message code="modal.orderStatus" />:</label>
										<div id="morderStatus"></div>
										<input type="hidden" id="mhorderNo" name="orderNo">
									</div>
								</td>
							</tr>
						</thead>


					</table>

					<table class="table table-hover" id="orderItemTable">
						<thead>
							<tr>
								<td colspan="8">
									<strong><spring:message code="modal.itemInfo" /></strong>
								</td>
								<td>
									<button type="button" class="btn btn-primary" onclick="addButton()"><spring:message code="modal.add" /></button>
								</td>
							</tr>
							<tr>
								<th scope="col">NO</th>
								<th scope="col"><spring:message code="table.itemCode" /></th>
								<th scope="row"><spring:message code="table.itemName" /></th>
								<th scope="col">박스규격</th>
								<th scope="col">BOX수량</th>
								<th scope="col"><spring:message code="table.itemPrice" /></th>
								<th scope="col"><spring:message code="table.saleQuantity" /></th>
								<th scope="col"><spring:message code="table.salePrice" /></th>
								<th scope="col"><spring:message code="line.delete" /></th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터 행이 여기에 추가됩니다 -->
						</tbody>
					</table>
					<div style="display: flex; justify-content: space-between; align-items: center;">
						<div style="text-align: center; flex-grow: 1;">
							<button type="button" id="mupdateStatus" class="btn btn-primary" onclick="updateStatus()"><spring:message code="modal.complete" /></button>
							<button type="button" id="save" class="btn btn-success" onclick="saveData()"><spring:message code="modal.save" /></button>
							<button type="button" id="close" class="btn btn-secondary" onclick="hideModal()"><spring:message code="modal.close" /></button>
						</div>
						<div style="text-align: right; text-align: right; font-weight: bold;">
							<span><spring:message code="modal.totalPrice" />:</span> <span id="totalPrice"></span>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<form id="hiddenform">
	<input type="hidden" id="hcompCd" name="compCd"> <input type="hidden" id="horderNo" name="orderNo"> <input type="hidden" id="saveCd">
</form>


<script src="/assets/js/common.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/paging.js"></script>
<script>
	function orderSearch(pno) {
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/order/getOrderList', getOrderList);
	}

	function getOrderList(vo) {
		$('#listTable > tbody').empty();
		var list = vo.orderlist;

		let spanArr = [];
		let rowspanCnt = 1;

		// rowspan 계산
		for (let i = 0; i < list.length - 1; i++) {
			if (list[i + 1].orderNo === list[i].orderNo) {
				rowspanCnt++;
			} else {
				spanArr.push(rowspanCnt);
				rowspanCnt = 1;
			}
		}
		spanArr.push(rowspanCnt); // 마지막 요소 추가

		let arrNo = 0;
		rowspanCnt = 1;
		let rowspan = spanArr[arrNo];

		// 테이블 행 생성 및 추가
		for (let i = 0; i < list.length; i++) {
			let str = "<tr onclick=\"displayModal('" + list[i].orderNo + "','"
					+ list[i].compCd + "','"
					+ getStatusName(list[i].orderStatus) + "','"
					+ list[i].deliveryDt + "');\" style='cursor:pointer;'>";
			str += "<th scope='row'>"
					+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
					+ "</th>";
			if (rowspanCnt === 1) { // 현재 행이 병합될 첫 번째 행인지 확인
				str += "<td rowspan='" + rowspan + "'>" + list[i].orderNo
						+ "</td>";
				str += "<td rowspan='" + rowspan + "'>" + list[i].compName
						+ "</td>";
			}
			str += "<td>" + list[i].itemCd + "</td>";
			str += "<td>" + list[i].itemName + "</td>";
			str += "<td>" + comma(list[i].unitPrice) + "</td>";//common.js에 있는 3자리씩 ','찍어주는 함수 
			str += "<td>" + comma(list[i].orderQty) + "</td>";//common.js에 있는 3자리씩 ','찍어주는 함수 
			str += "<td>" + comma(list[i].orderPrice) + "</td>";//common.js에 있는 3자리씩 ','찍어주는 함수 
			str += "<td>" + getStatusName(list[i].orderStatus) + "</td>";
			str += "<td>" + list[i].deliveryDt + "</td>";
			str += "<td>" + list[i].regDt + "</td>";
			str += "</tr>";

			if (rowspanCnt === rowspan) { // 현재 rowspan 값이 끝났는지 확인
				rowspanCnt = 1;
				arrNo++;
				rowspan = spanArr[arrNo];
			} else {
				rowspanCnt++;
			}

			$('#listTable > tbody').append(str); // 생성된 행을 테이블에 추가
		}
		setPaging(orderPaging, vo.startPage, vo.endPage, 'orderSearch');
	}

	function getStatusName(staCd) {
		if (staCd == 1) {
			return "대기"
		} else {
			return "완료"
		}
	}

	function displayModal(ordNo, comCd, sta, delDt) { // 모달 띄우기
		$('#modalform')[0].reset();
		$('#orderItemTable > tbody').empty();
		$('#morderStatus').text('');
		$('#totalPrice').text('');
		$('#saveCd').val('insert'); // 기본값을 'insert'로 설정
		$('#save').prop('disabled', false);
		$('#mupdateStatus').prop('disabled', true); // 신규 상태에서는 발송 완료 버튼 비활성화

		if (ordNo !== '0') {
			$('#mcompCd').val(comCd);
			$('#morderNo').val(ordNo);
			$('#morderStatus').text(sta);
			$('#saveCd').val('update'); // 기존 주문 수정 시 'update'로 설정

			if (delDt != null) {
				$('#mdeliveryDt').val(delDt);
			}

			if (sta === "대기") {
				$('#save').prop('disabled', false); // 대기 상태에서는 저장 버튼 활성화
				$('#mupdateStatus').prop('disabled', false); // 대기 상태에서는 발송 완료 버튼 활성화
			} else if (sta === "완료") {
				$('#save').prop('disabled', true); // 완료 상태에서는 저장 버튼 비활성화
				$('#mupdateStatus').prop('disabled', true); // 완료 상태에서는 발송 완료 버튼 비활성화
			}

			$('#hcompCd').val(comCd);
			$('#mhorderNo').val(ordNo);
			$('#horderNo').val(ordNo);
			call_server(hiddenform, '/order/setRowData', setRowData);
		}
		$('#orderModal').modal('show');
	}

	function disabledButtonAndInput(cd) { // new:신규, wait:대기, compl:완료
		$(
				'#modalform button:not(#close), #modalform input:not([type="hidden"])')
				.each(function() {
					if (cd === 'compl') {
						$(this).prop('disabled', true);
						$(this).prop('readonly', true);
					} else if (cd === 'new') {
						$(this).prop('disabled', false);
						$(this).prop('readonly', false);
					} else {
						$(this).prop('readonly', false);
					}
				});
	}

	var w;
	function searchManage(no, where) { //거래처 팝업창 띄우기
		w = where;
		row = no;

		var option = "width = 1000, height = 700, top = 100, left = 200"
		window.open('/receive/rcv01pop1', 'popup', option);
	}
	function receivePartnerData(rcvData) { // 거래처 인풋에 입력
		if (w == 'modal') {
			$('#mcompCd').val(rcvData.compCd);
		} else {
			$('#compName').val(rcvData.compName);
			$('#compCd').val(rcvData.compCd);
		}

	}

	function addButton() { // 모달 안 +버튼 클릭 시
		setRowData([ {
			itemCd : '',
			itemName : '',
			boxType : '',
			boxQty : '',
			unitPrice : '',
			orderPrice : '',
			orderQty : ''
		} ]);
	}

	var rowidx = 1;
	function setRowData(list) { // 모달 조회
		if (!list) {
			list = [ {
				itemCd : '',
				itemName : '',
				boxType : '',
				boxQty : '',
				unitPrice : '',
				orderPrice : '',
				orderQty : ''
			} ];
		}
		for (var i = 0; i < list.length; i++) {
			var str = '<tr>';
			str += '<td>' + rowidx + '</td>';
			str += '<td>';
			str += '<div style="position: relative;">';
			str += '<input type="text" id="itemCd' + rowidx + '" name="orderlist[' + rowidx + '].itemCd" value="' + list[i].itemCd + '" class="form-control" style="padding-right: 30px; width:100px;">';
			str += '<i class="ri-search-2-line" onclick="additem('
					+ rowidx
					+ ')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>';
			str += '</div>';
			str += '</td>';
			str += '<td><input type="text" id="itemName' + rowidx + '" value="' + list[i].itemName + '" class="form-control" style="width:100px;" readonly></td>';
			str += '<td><input type="text" id="boxType' + rowidx + '" name="orderlist[' + rowidx + '].boxType" value="' + list[i].boxType + '" class="form-control" style="width:80px;" readonly></td>';
			str += '<td><input type="text" id="boxQty' + rowidx + '" name="orderlist[' + rowidx + '].boxQty" value="' + list[i].boxQty + '" class="form-control" style="width:80px;" readonly></td>';
			str += '<td><input type="text" id="unitPrice' + rowidx + '" name="orderlist[' + rowidx + '].unitPrice" value="' + list[i].unitPrice + '" class="form-control" style="width:80px;" readonly></td>';
			str += '<td><input type="text" id="orderPrice'
					+ rowidx
					+ '" name="orderlist['
					+ rowidx
					+ '].orderPrice" value="'
					+ list[i].orderPrice
					+ '" class="form-control" style="width:80px;" onblur="getTotalPrice();"></td>';
			str += '<td><input type="text" id="orderQty'
					+ rowidx
					+ '" name="orderlist['
					+ rowidx
					+ '].orderQty" value="'
					+ list[i].orderQty
					+ '" class="form-control" style="width:80px;" onblur="getTotalPrice();"></td>';
			str += '<td><button type="button" class="btn btn-danger" onclick="delTr(this)">삭제</button></td>';
			str += '</tr>';
			rowidx++;
			$('#orderItemTable').append(str);
		}
		getTotalPrice();
	}

	function delTr(obj) { // 모달 안 삭제 펑션
		$(obj).closest('tr').remove();
		getTotalPrice();
		reindexRows(); // No 열을 다시 정렬하는 함수 호출
	}

	function reindexRows() {
		var rowIndex = 1;
		$('#orderItemTable tbody tr').each(function() {
			$(this).find('td:first').text(rowIndex);
			rowIndex++;
		});
	}

	//데이터 저장
	function saveData() {
		if (checkFormFields()) {
			var saveCd = $('#saveCd').val();
			if (saveCd == 'update') {
				call_server(modalform, '/order/updateOrderDtl', result);
			} else {
				call_server(modalform, '/order/insertNewOrderDate', result);
			}
		}
	}

	function checkFormFields() {
		$('#modalform input:not([type="hidden"])').each(function() {
			if ($(this).val() === '') {
				alert('모든 필드를 채워주세요.');
				$(this).focus();
				return false; // loop 중지
			}
		});
		return true;
	}
	function result(cnt) {
		if (cnt > 0) {
			alert("저장완료");
			$('#orderModal').modal('hide');
			orderSearch(1);
			rowidx = 1;
		}
	}

	function updateStatus() {
		call_server(hiddenform, '/order/updateStatus', result);
	}

	function getTotalPrice() {
		totalPrice = 0; // 총 가격 초기화
		$('#orderItemTable tbody tr')
				.each(
						function() {
							var orderPrice = $(this).find(
									'input[id^="orderPrice"]').val();
							var orderQty = $(this)
									.find('input[id^="orderQty"]').val();
							if (!isNaN(orderPrice) && !isNaN(orderQty)
									&& orderPrice !== "" && orderQty !== "") {
								totalPrice += (parseFloat(orderPrice) * parseFloat(orderQty));
							}
						});
		$('#totalPrice').text(comma(totalPrice) + "원"); // 총 가격 업데이트
	}

	function hideModal() {
		$('#orderModal').modal('hide');
		rowidx = 1;
	}

	var activeRow = 0;
	function additem(no) { //품번 팝업클릭시
		activeRow = no;
		var option = "width = 1000, height = 700, top = 100, left = 200"
		window.open('/item/bom01pop1', 'popup', option);
	}

	var checkCd = [];
	function receiveItemData(item) { // 품번팝업에서 가져오는값
		for (var i = 0; i < checkCd.length; i++) {
			if (checkCd[i].itemCd == item.itemCd) {
				alert("이미선택된 품목입니다.")
				return;
			}
		}
		$('#itemCd' + activeRow).val(item.itemCd);
		$('#itemName' + activeRow).val(item.itemName);
		$('#boxType' + activeRow).val(item.boxType);
		$('#boxQty' + activeRow).val(item.boxQty);
		$('#unitPrice' + activeRow).val(item.unitPrice);
		checkCd.push(item);
	}

	function validateDeliveryDate() {
		var deliveryDate = new Date($('#mdeliveryDt').val());
		var today = new Date();
		today.setHours(0, 0, 0, 0); // 오늘 날짜의 시간을 0으로 설정

		if (deliveryDate < today) {
			alert("잘못된 입력값입니다.");
			$('#mdeliveryDt').val(''); // 잘못된 날짜를 선택한 경우 입력 필드를 초기화
		}
	}
</script>
