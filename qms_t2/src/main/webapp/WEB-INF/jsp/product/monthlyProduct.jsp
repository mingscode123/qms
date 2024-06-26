<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>월별 소요자재 조회</title>
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
											<th>계획년월</th>
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="mthProYear" name="mthProYear">
												<option value=''>==년==</option>
											</select></td>
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="mthProMonth" name="mthProMonth">
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
											</select></td>

										
										<td>
											<th>거래처</th>
										<td>
											<input type='hidden' id='compCd' name='compCd'>
											<input type="text" class="form-control" id="compName" name="compName" style = "width:200px;" onkeyup="changeCompName(this);">
										</td>
										
										<td>
										<div class="icon" >
										<i class="ri-search-2-line" onclick="searchManage(1)"></i>
										<div class="label"></div></div></td>
										
										<td rowspan="1">
											<button type="button" class="btn btn-info" onclick="mSearch(1);">조회
											</button>
											<button type="button" class="btn btn-info" id="mthProExcel">엑셀
											</button>
										</td>
								</tr>

							</table>

						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="boardTable">
							<thead>
							<tr>
								<td>NO</td>
								<td>품번</td>
								<td>품명</td>
								<td>자재품번</td>
								<td>자재품명</td>
								<td>생산수량</td>
								<td>투입수량</td>
								<td>소요수량</td>
								
							</thead>
							
							<tbody>
							
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="mthProPaging">

							</ul>
						</nav>
						<!-- End Pagination with icons -->

					</div>
				</div>
			</div>
		</div>
	</section>
</main>
<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>
		function searchManage(){
			var  option= "width = 1000, height = 700, top = 100, left = 200"
				window.open('/receive/rcv01pop1','popup',option);
		}
		
		var compNm="";
		
		function receivePartnerData(item) { // 선택한곳에 거래처 보여주기
			$('#compCd').val(item.compCd);
			$('#compName').val(item.compName);
			compNm=item.compName;
		}
		
//======================================================================= 거래처 선택		
		
		var now = new Date(); // 현재 날짜
		var year = now.getFullYear(); //현재 년도
		var month = now.getMonth()+1; //현재 월
		var baseYear = ${baseYear}; // constant에서 가져온baseYear
		
		
		for(var i=baseYear; i<=year; i++){
			$('#mthProYear').append("<option value='"+i+"'>"+i+"</option>"); // 헤더부분 셀렉단
		}
		if(month<10){
			$('#mthProMonth').val('0'+month); //헤더부분 현재년월로 세팅
		}else{
			$('#mthProMonth').val(month); //헤더부분 현재년월로 세팅
		}
		
		$('#mthProYear').val(year);
	
		function getLastDay(){
			var last = new Date($('#mthProYear').val(),$('#mthProMonth').val(),00); //year-month-마지막일
			var lastDate = last.getDate(); //마지막일
			return lastDate;
		}
//======================================================================= 년월 선택		
	function mSearch(pno){
		
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		
		call_server(searchform,'/product/mthProductList',mthProductList);
	}
	function mthProductList(vo){
		$('#boardTable tbody').empty();
		list = vo.mthProList;
		for(var i=0; i<list.length; i++){
			str = "<tr>";
			str += "<td>"+(i+1)+"</td>";
			str += "<td>"+list[i].itemCd+"</td>";
			str += "<td>"+list[i].itemName+"</td>";
			str += "<td>"+list[i].sitemCd+"</td>";
			str += "<td>"+list[i].sitemName+"</td>";
			str += "<td>"+list[i].productQty+"</td>";
			str += "<td>"+list[i].insQty+"</td>";
			str += "<td>"+list[i].demandQty+"</td>";
			str += "</tr>";
			
			$('#boardTable tbody').append(str);
			}
			setPaging(mthProPaging, vo.startPage, vo.endPage, 'mSearch');
		}
	
		function changeCompName(obj){
			if(compNm!=$(obj).val()){
				$('#compCd').val('');
				$('#compName').val('');
			}
		}
//=======================================================================================조회	
	$(document).ready(function() {
		$('#mthProExcel').click(function() {
		excelDownload( searchform, '/mthProExcel/excelDownload', 'monthlyProduct.xlsx');
			});
		});
///===================================================================================== 엑셀	
</script>