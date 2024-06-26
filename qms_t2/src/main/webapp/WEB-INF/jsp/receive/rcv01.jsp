<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>제품조회</title>
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

<%@ include file="../layout/menu.jsp"%>

<main id="main" class="main">

	<section class="section">
		<div class="row">
			<div class="col-lg-12">

				<div class="card">
					<div class="card-body" style="padding-top: 20px;">
						<!-- General Form Elements -->
						<form id="searchform">
							<input type='hidden' id='currentPage' name='currentPage' value=1>
							<table class="col-lg-12">
								<tr>
									<td style=  "text-align: right;">
										<div class="row mb-3">
											<label for="inputDate" class="col-sm-1 col-form-label">입고일</label>
											<div class="col-sm-2">
												<input type="date" class="form-control" id="inDtFrom" name="inDtFrom"
												style = "wight : 150px">
											</div>
											~
											<div class="col-sm-2">
												<input type="date" class="form-control" id="inDtTo" name="inDtTo"
												style = "wight : 150px">
											</div>

											<label for="inputText" class="col-sm-2 col-form-label">인보이스 번호</label>
											<div class="col-sm-1">
												<input type="text" class="form-control" id="invoiceNo" name="invoiceNo"
												style = "wight : 150px">
											</div>

											<label for="inputText" class="col-sm-1 col-form-label" >거래처</label>
											<div class="col-sm-2">
												<input type="text" class="form-control" id="compName" name="compName" style = "wight:200px">
												<div class="icon" >
												<i class="ri-search-2-line" onclick="searchManage(0)"></i>
												<div class="label"></div>
											</div>
										</div>


									</td>
									<td rowspan="1">
										<button type="button" class="btn btn-info" onclick="rcvSearch();">조회</button>
										<button type="button" class="btn btn-info" onclick="displayModal();">신규</button>
									</td>
								</tr>

							</table>



						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="listTable">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">입고일</th>
									<th scope="col">거래처명</th>
									<th scope="col">INVOICE NO</th>
									<th scope="col">총금액(원)</th>
									<th scope="col">품목수</th>
									<th scope="col">등록일</th>
									<th scope="col">다운로드</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="rcvPaging">

							</ul>
						</nav>
						<!-- End Pagination with icons -->

					</div>
				</div>
			</div>
		</div>
	</section>
</main>
<%@ include file="../layout/footer.jsp"%>

<div class="modal fade" id="rcvModal" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">입고 등록/수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
			<form id="modalform">
			<input type="text" id="rcvNo" name="rcvNo">
				<table class="table table-hover" id="productOrderingDetailTable" >
					<thead>
						<tr>
							<th scope="row">INVOICE NO</th>
							<td>
							<input type="text" class="form-control" id="minvoiceNo" name="invoiceNo">
							</td>
							<td colspan="9" style="text-align:right;"><button type="button" class="btn btn-primary" onclick="searchit()">조회</button>
								<button type="button" class="btn btn-info" onclick="itemUpDate();">저장</button></td>
							</tr>
							<tr>
							<th scope="row">거래처코드</th>
							<td>
							<input type="text" class="form-control" id="mcompCd" name="compCd">
							</td><td>
							<div class="icon" >
							<i class="ri-search-2-line" onclick="searchManage(1)"></i>
							<div class="label"></div></div></td>
							<th scope="row">거래처명</th>
							<td>
							<input type="text" class="form-control" id="mcompName" name="compName">
							</td>
							<th scope="row">입고일</th>
							<td>
							<div class="col-sm-8">
							<input type="date" class="form-control" id="minDt" name="inboundDtFrom">
							</div>
							</td>
						</tr>
						<tr>
						
						
						</tr>
					</thead>
					</table>
					<table class="table table-hover" id="rcvTable">
					<tbody>
					<tr>
					<td colspan="9" style="text-align: right;">
					<table style = "width: 100%;">
						<tr><td style = "text-align: left";>품목정보</td><td style="text-align:right;"><button type="button" class="btn btn-primary" onclick="addButton()">+</button></td></tr>
					</table>
			    	 
   					</td>
   					</tr>
					<tr>
							<th scope="col">NO</th>
							<th scope="col">품번</th>
							<th scope="row">품명</th>
							<th scope="col">박스규격</th>
							<th scope="col">BOX수량</th>
							<th scope="col">입고수량</th>
							<th scope="col">단가</th>
							<th scope="col">재고위치</th>
							<th scope="col">삭제</th>
						</tr>
					</tbody>
				</table>
			</form>
			</div>
		</div>
	</div>
</div>


<!-- End Vertically centered Modal-->

<form id="hiddenform">
	<input type="hidden" id="invoice" name="invoiceNo">
</form>


<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>
function rcvSearch() {
	call_server(searchform, '/receive/selectRcvList', selectRcvList);
}

function selectRcvList(vo) {
    $('#listTable > tbody').empty();
    var list = vo.rcvlist;

    for (var i = 0; i < list.length; i++) {
        var str = "<tr onclick=\"ModalDtl('" + list[i].invoiceNo + "','" + list[i].compCd + "','" + list[i].compName + "','" + list[i].inDt + "');\" style=\"cursor:pointer;\">";
        str +="<th scope=\"row\">"+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))+ "</th>";
        str += "<td>" + list[i].inDt + "</td>";
        str += "<td>" + list[i].compName + "</td>";
        str += "<td>" + list[i].invoiceNo + "</td>";
        str += "<td>" + Number(list[i].totalPrice).toLocaleString() + "원</td>";
        str += "<td>" + list[i].itemCnt + "</td>";
        str += "<td>" + list[i].regDt + "</td>";
        str += "<td><a href='/attachment/pdf?invoiceNo=" + list[i].invoiceNo + "&pdfFileName=invoice' onclick='event.stopPropagation();'><i class='bi bi-file-earmark-pdf-fill' style='font-size: 1.5em;'></i></a></td>";
        str += "</tr>";
        $('#listTable').append(str);
    }
    setPaging(rcvPaging, vo.startPage, vo.endPage, 'rcvSearch');
}



function downloadPdf() {
    var url = "/attachment/pdf";
    window.location.href = url;
}

<!--이 밑으로 모달-->
var row = 0;
function searchManage(no){ // 거래처 셀렉
	row = no;
var  option= "width = 1000, height = 700, top = 100, left = 200"
	window.open('/receive/rcv01pop1','popup',option);
}

function receivePartnerData(item) { // 선택한곳에 거래처 보여주기
	if(row == "0"){
	$('#compCd').val(item.compName);
	}else{
	$('#compNm').val(item.compName);
	$('#comCd').val(item.compCd);
	}
}

function displayModal(){ //신규
	$('#rcvModal').modal('show');
}





function ModalDtl(no,cd,nm,dt,rc){ // 본페이지에서 조회후 조회된값 클릭시 헤더부분에 띄워준후 콜서버
	
	$('#rcvNo').val(rc);
	$('#minvoiceNo').val(no);
	$('#mcompCd').val(cd);
	$('#mcompName').val(nm);
	$('#minDt').val(dt);
	call_server(modalform,'/selectRcvClickList',RcvclickList);
}
var checkCd = [];
function RcvclickList(list){ // 본페이지 조회후 조회된값 상세 모달
	$('#listTable > tbody').empty();
	for(var i = 0; i < list.length; i++){
	    setRowData(list[i]);
	    checkCd = list;
	}
	$('#rcvModal').modal('show');
}


var activeRow = 0;
function additem(no){ //품번 팝업클릭시
	activeRow = no;
	var  option= "width = 1000, height = 700, top = 100, left = 200"
	window.open('/item/bom01pop1','popup',option);
}
function receiveItemData(item) { // 품번팝업에서 가져오는값
	console.log(checkCd);
	console.log(item);
	for(var i = 0; i<checkCd.length; i++){
		if(checkCd[i].itemCd == item.itemCd){
			alert("이미선택된 품목입니다.")
			return;
		}
	}
	
	$('#addCd'+activeRow).val(item.itemCd);
	$('#addNm'+activeRow).val(item.itemName);
	$('#boxType'+activeRow).val(item.boxType);
	$('#boxQty'+activeRow).val(item.boxQty);
	checkCd.push(item);
}
function searchit(){ //모달안 조회버튼
	call_server(modalform,'/selectRcvClickList',RcvclickList);
}

function selectrcvDtlList(vo){ //모달안조회 버튼 클릭시
	console.log(vo);
	$('#rcvNo').val(vo.headlist.rcvNo);
	$('#minvoiceNo').val(vo.headlist.invoiceNo);
	$('#mcompCd').val(vo.headlist.compCd);
	$('#mcompName').val(vo.headlist.compName);
	$('#minDt').val(vo.headlist.inDt);
	$('#listTable > tbody').empty();
	$('#minvoiceNo').val(vo.invoiceNo);
list = vo.headlist;
if(list!=null){
	for(var i = 0; i < list.length; i++){
		setRowData(list[i]);
    }
}
}




function addButton(){ // 모달안 +버튼 클릭시
	setRowData(null);
}


var rowidx = 0;
var cnt = 1;
function setRowData(vo){ // 모달 조회 공통쿼리
	if(vo==null){
		vo = new Object();
		vo.itemCd='';
		vo.itemName='';
		vo.boxType='';
		vo.boxQty = '';
		vo.inQty='';
		vo.inPrice='';
	}else{
		console.log(vo);
	}
	str = "<tr>";
	str += "<td>"+cnt+"</td>";
    str += "<td><input type=\"text\" id=\"addCd"+rowidx+"\" name=\"rcvlist["+rowidx+"].itemCd\" value='"+vo.itemCd+"'class=\"form-control\">";
    str += "<div class=\"icon\" >";
	str += "<i class=\"ri-search-2-line\"onclick=\"additem("+rowidx+")\"></i>";
	str += "<div class=\"label\"></div>";
	str += "</div>";
    str += "<td><input type=\"text\" id=\"addNm"+rowidx+"\" value='"+vo.itemName+"'class=\"form-control\"></td>";
	str += "<td><input type=\"text\" id=\"boxType"+rowidx+"\" name =\"rcvlist["+rowidx+"].boxType\"value='"+vo.boxType+"'class=\"form-control\"></td>";
    str += "<td><input type=\"text\" id=\"boxQty"+rowidx+"\" name =\"rcvlist["+rowidx+"].boxQty\" value='"+vo.boxQty+"'class=\"form-control\"></td>";
    str +=  "<td class=\"form-control\"><input type='text' id=\"inQty"+rowidx+"\" name =\"rcvlist["+rowidx+"].inQty\" value='"+vo.inQty+"'></td>";
    str += "<td><input type=\"text\" name=\"rcvlist["+rowidx+"].inPrice\" value='"+vo.inPrice+"'class=\"form-control\"></td>";
    str +=  "<td ><select id=\"location"+rowidx+"\" name=\"rcvlist["+rowidx+"].location\"style=\"width:200px;\"class=\"form-control\"><option value=>== 선택 ==</option><option value=\"A1\">A1</option><option value=\"A2\">A2</option><option value=\"A3\">A3</option><option value=\"A4\">A4</option><option value=\"A5\">A5</option></select></td>";
    str +=  "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"delTr(this)\">삭제</button></td>"; 
    str +=  "</tr>";
    $('#rcvTable').append(str);
    $('#location'+rowidx).val(vo.location);
    rowidx++;
    cnt++;
	}
	
	
function delTr(obj){ //모달안 삭제펑션
	$(obj).closest('tr').remove();
	cnt -= 1;
}

function itemUpDate(){
	call_server(modalform,'/RCVNewInsertAdd',RCVDelInsertAdd);
}
function RCVDelInsertAdd(cnt){
	if (cnt > 0 ) {
	    alert("등록완료");
	    $('#rcvModal').modal('hide');
	    rcvSearch();
	} else {
	    alert("실패");
	}
}



</script>