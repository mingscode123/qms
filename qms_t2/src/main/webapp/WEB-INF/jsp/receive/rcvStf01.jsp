<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>입고 품목 조회</title>
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
												<input type="date" class="form-control" id="regDtFrom" name="regDtFrom"
												style = "wight : 150px">
											</div>
											~
											<div class="col-sm-2">
												<input type="date" class="form-control" id="regDtTo" name="regDtTo"
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
												<input type="hidden" id="compCd" name="compCd">
												<div class="icon" >
												<i class="ri-search-2-line" onclick="searchManage()"></i>
												<div class="label"></div>
											</div>
										</div>


									</td>
									<td rowspan="1">
										<button type="button" class="btn btn-info" onclick="search();">조회</button>
										<button type="button" class="btn btn-info" id="downloadBtn" >엑셀</button>
									</td>
								</tr>

							</table>



						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="receiveStuffTable">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">품번</th>
									<th scope="col">품명</th>
									<th scope="col">INVOICE NO</th>
									<th scope="col">입고수량</th>
									<th scope="col">입고단가</th>
									<th scope="col">재고위치</th>
									<th scope="col">입고일</th>
									<th scope="col">입고상태</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="receivePaging">

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
			<input type="hidden" id="iutype" name="iutype">
				<table class="table table-hover" id="productOrderingDetailTable" >
					<thead>
						<tr>
							<th scope="row">INVOICE NO</th>
							<td>
							<input type="text" class="form-control" id="itCd" name="itemCd">
							</td>
							<td colspan="9" style="text-align:right;"><button type="button" class="btn btn-primary" onclick="searchit()">조회</button>
								<button type="button" class="btn btn-info" onclick="itemUpDate();">저장</button></td>
							</tr>
							<tr>
							<th scope="row">거래처코드</th>
							<td>
							<input type="text" class="form-control" id="comCd" name="compCd">
							</td><td>
							<div class="icon" >
							<i class="ri-search-2-line" onclick="searchManage(1)"></i>
							<div class="label"></div></div></td>
							<th scope="row">거래처명</th>
							<td>
							<input type="text" class="form-control" id="compNm" name="compName">
							</td>
							<th scope="row">입고일</th>
							<td>
							<div class="col-sm-8">
							<input type="date" class="form-control" id="joinDtFrom" name="inboundDtFrom">
							</div>
							</td>
						</tr>
						<tr>
						
						
						</tr>
					</thead>
					</table>
					<table class="table table-hover" id="BomSelectT">
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
	<input type="hidden" id="hitemCd" name="itemCd">
</form>


<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>
		function search(pno){
			
			if (pno == undefined) {
				$('#currentPage').val(1);
			} else {
				$('#currentPage').val(pno);
			}
			
			call_server(searchform,'/recieve/searchList',searchList);
		}
		
		function searchList(vo){
		list = vo.receivelist;
		$('#receiveStuffTable >tbody').empty();
		
		console.log(list);
		
		for(var i=0; i<list.length; i++){
			str = "<tr>";
			str += "<th scope=\"row\">"
				+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
				+ "</th>";
			
			str += "<td>"+list[i].itemCd+"</td>";
			str += "<td>"+list[i].itemName+"</td>";
			str += "<td>"+list[i].invoiceNo+"</td>";
			str += "<td>"+list[i].inQty+"</td>";
			str += "<td>"+list[i].inPrice+"</td>";
			str += "<td>"+list[i].comName+"</td>";
			str += "<td>"+list[i].inDt+"</td>";
			str += "<td>"+list[i].inStatus+"</td>";
			str += "<td>"+list[i].regDt+"</td>";
			str += "</tr>";
			
			$('#receiveStuffTable >tbody').append(str);
			}
			setPaging(receivePaging, vo.startPage, vo.endPage, 'search');
		}
		function searchManage(){ // 거래처 셀렉
		    
		var  option= "width = 1000, height = 700, top = 100, left = 200"
		    window.open('/receive/rcv01pop1','popup',option);
		}
		
		function receivePartnerData(item) { // 선택한곳에 거래처 보여주기
		   
		    $('#compCd').val(item.compCd);
		   
		    $('#compName').val(item.compName);
		    
		}
			$(document).ready(function() {
			$('#downloadBtn').click(function() {
			excelDownload('/receive/excelDownload', 'receiveStuff.xlsx');
				});
			});

</script>