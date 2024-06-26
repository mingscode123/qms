<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
  #listTable th, #listTable td {
    border: 1px solid gray; /* 1px 회색 테두리 추가 */
  }

</style>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>일별주문조회</title>
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
				<table class="table table-borderless">
					<tr>
						<td style="text-align: right;" colspan="2"><label for="deliveryDtFrom" class="col-form-label">배송일</label></td>
						<td><input type="date" class="form-control"  id="deliveryDtFrom" name="deliveryDtFrom"></td>
						<td style="text-align: center;">~</td>
						<td><input type="date" class="form-control"  id="deliveryDtTo" name="deliveryDtTo"></td>

						<td style="text-align: right;" colspan="2"><label for="compName" class="col-form-label">품번</label></td>
						<td><input type="text" class="form-control" name="itemCd"></td>

						<td style="text-align: right;" colspan="2"><label for="compName" class="col-form-label">거래처</label></td>
						<td>
							<div style="position: relative;">
								<input type="text" class="form-control" id = "compName" name="compName" style="padding-right: 30px;"> <i class="ri-search-2-line" onclick="searchManage(0,'page')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
								<input type="hidden" id = "compCd" name="compCd">
							</div>
						</td>

						<td colspan="3" style="text-align: left;">
							<button type="button" class="btn btn-info" onclick="dailyOrderSearch();">조회</button>
							<button type="button" class="btn btn-success" id="downloadBtn">엑셀 다운로드</button>
						</td>
					</tr>
				</table>
			</form>
			<div class="card">
				<div class="card-body">
					<!-- Table with hoverable rows -->
					<table class="table table-hover" id="listTable">
						
					</table>

					<!-- End Table with hoverable rows -->

				</div>
			</div>

		</section>
	</main>
	<!-- End #main -->


	<!-- ======= Footer ======= -->
	<%@ include file="../layout/footer.jsp"%>





<script src="/assets/js/common.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script>
//서치폼쪽 세팅
$(document).ready(function() {
    var today = new Date();
    var monthLater = new Date();
    monthLater.setDate(today.getDate() + 30);

    var todayStr = today.toISOString().split('T')[0];
    var monthLaterStr = monthLater.toISOString().split('T')[0];

    $('#deliveryDtFrom').val(todayStr);
    $('#deliveryDtTo').val(monthLaterStr);

});
//와쿠만들기
var dateAry = []; 
function dailyOrderSearch(){
    $('#listTable').empty();
    $('#listTable').append(
        '<thead>' +
        '<tr>' +
        '<th scope="col">No</th>' +
        '<th scope="col">거래처명</th>' +
        '<th scope="col">품번</th>' +
        '<th scope="col">품명</th>' +
        '<th scope="col">SUM</th>' +
        '</tr>' +
        '</thead>' +
        '<tbody>' +
        '</tbody>'
    );

    // 초기화
    dateAry = [];
    rowCnt = 0;
    totalSum = 0;

    var from = $('#deliveryDtFrom').val();
    var to = $('#deliveryDtTo').val();
    var startDate = new Date(from);
    var endDate = new Date(to);

    while (startDate <= endDate) {
        var month = (startDate.getMonth() + 1).toString().padStart(2, '0'); 
        var day = startDate.getDate().toString().padStart(2, '0');
        var dateStr = month + '-' + day; 
        $('#listTable thead tr').append('<th scope="col" id="' + dateStr + '">' + dateStr + '</th>');
        dateAry.push(dateStr);
        startDate.setDate(startDate.getDate() + 1);
    }
    call_server(searchform, '/order/getDailyOrderList', getDailyOrderList);
}

var rowCnt =  0;
var totalSum = 0;
//데이터 뿌려주기
function getDailyOrderList(list){
	
	var str = "<tr>"; 
    str += "<td colspan = '4'>Total</td>"; 
    str += "<td id='totalSumTd'></td>"; 
    for (var j = 0; j < dateAry.length; j++) {
    	str += "<td>"+getDaySum(dateAry[j],list)+"</td>";
    }
    str += "</tr>";
    $('#listTable thead').append(str);
	
    var addedItems = new Set();
    
    for (var i = 0; i < list.length; i++) {
        var key = list[i].compCd + '|' + list[i].itemCd; // 고유 키 생성, compCd 사용
        totalSum += parseInt(list[i].orderQty, 10);
        if (!addedItems.has(key)) { 
        	rowCnt++;
            addedItems.add(key); 

            var str = "<tr data-compcd='" + list[i].compCd + "'>"; // 행에 기업 코드를 데이터 속성으로 추가 <--
            str += "<td>" + rowCnt + "</td>"; 
            str += "<td>" + list[i].compName + "</td>";
            str += "<td>" + list[i].itemCd + "</td>";
            str += "<td>" + list[i].itemName + "</td>";
            str += "<td>" + getRowSum(list[i].itemCd,list[i].compCd,list);  + "</td>";
            
            for (var j = 0; j < dateAry.length; j++) {
                var deliveryDt = list[i].deliveryDt;
                if (deliveryDt === dateAry[j]) {
                    str += '<td>' + list[i].orderQty + '</td>';
                } else {
                    str += '<td></td>';
                }
            }
            str += "</tr>";
            
            $('#listTable tbody').append(str);
        } else {
            $('#listTable tbody tr').each(function() {
                var row = $(this); 
                var compCd = row.data('compcd'); 
                var itemCd = row.find('td:eq(2)').text(); 

                if (key === (compCd + '|' + itemCd)) {
                    for (var j = 0; j < dateAry.length; j++) { 
                        var deliveryDt = list[i].deliveryDt; 
                        if (deliveryDt === dateAry[j]) { 
                            row.find('td:eq(' + (j + 5) + ')').text(list[i].orderQty);
                        }
                    }
                }
            });
        }
    }
    $('#totalSumTd').text(totalSum);
}


function getDaySum(day, list){
	var sum = 0;
	for(var i=0;i<list.length;i++){
		if(list[i].deliveryDt==day){
			sum+=Number(list[i].orderQty);
		}
	}
	return sum;
}

function getRowSum(itemCd,compCd,list){
	var sum = 0;
	for(var i=0;i<list.length;i++){
		if(list[i].itemCd==itemCd && list[i].compCd==compCd){
			sum+=Number(list[i].orderQty);
		}
	}
	return sum;
}

$(document).ready(function() {
    $('#downloadBtn').click(function() {
    	excelDownload(searchform, '/order/excelDownload', 'order_data.xlsx');
    });
}); //엑셀 다운로드 함수 


</script>
