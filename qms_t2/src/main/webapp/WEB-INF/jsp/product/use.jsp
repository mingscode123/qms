<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>생산계획조회</title>
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
		<form id="searchform">
		<div class="row">
			<div class="col-lg-12">
				
				<div class="card">
					<div class="card-body" style="padding-top: 20px;">
						<!-- General Form Elements -->
						
							<input type='hidden' id='currentPage' name='currentPage' value=1>
							
							<table class="col-lg-12">
								<tr>
									<td style=  "text-align: right;">
											<th>계획년월</th>
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="planYear" name="planYear">
												<option value=''>==년==</option>
											</select></td>
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="planMonth" name="planMonth">
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

											<th>거래처</th>
												<td><input type='hidden' id='compCd' name='compCd'><input type="text" class="form-control" id="compName" name="compName" style = "wight:150px"></td>
												<td>
												<div class="icon" >
												<i class="ri-search-2-line" onclick="searchManage(1)"></i>
												<div class="label"></div></div></td>
										
									<td rowspan="1">
										<button type="button" class="btn btn-secondary mb-2" onclick="useSearch();">조회</button>
										<button type="button" class="btn btn-success mb-2" id ="excelD">엑셀 다운로드</button>
									</td>
								</tr>

							</table>

						

					</div>
				</div>
				<div class="card">
				
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover">
			             <thead>
			               <tr>
			                 <th scope="col">NO</th>
			                 <th scope="col">품번</th>
			                 <th scope="col">품명</th>
			                 <th scope="col">자재품번</th>
			                 <th scope="col">자재품명</th>
			                 <th scope="col">생산수량</th>
			                 <th scope="col">투입수량</th>
			                 <th scope="col">소요수량</th>
			               </tr>
			             </thead>
			             <tbody id="cardtbody">
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
		</form>
	</section>
</main>
<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>
	var now = new Date(); // 현재 날짜
	var year = now.getFullYear(); //현재 년도
	var month = now.getMonth()+1; //현재 월
	var baseYear = ${baseYear}; // constant에서 가져온baseYear
	
	for(var i=baseYear;i<=year;i++){
		$('#planYear').append("<option value='"+i+"'>"+i+"</option>"); // 헤더부분 셀렉단
	}
	if(month<10){
		$('#planMonth').val('0'+month); //헤더부분 현재년월로 세팅
	}else{
		$('#planMonth').val(month); //헤더부분 현재년월로 세팅
	}
	
	$('#planYear').val(year);
	
	function useSearch(){ // 년월 세팅후 조회버튼 클릭시
		$('#cardtbody').empty();
		call_server(searchform, '/selectUseBomInfo', selectUseBomInfo);
	}
	   function selectUseBomInfo(list){
	        for(var i = 0; i < list.length; i++){
	            var str = "<tr>";
	            str += "<td>"+(i+1)+"</td>";
	            str += "<td>"+list[i].itemCd+"</td>";
				str += "<td>"+list[i].itemName+"</td>";
				str += "<td>"+list[i].sitemCd+"</td>";
				str += "<td>"+list[i].sitemName+"</td>";
				str += "<td>"+list[i].productQty+"</td>";
				str += "<td>"+list[i].insQty+"</td>";
				str += "<td>"+list[i].productQty*list[i].insQty+"</td>";
				str += "</tr>"
				$("#cardtbody").append(str);
	            }
	   }
                    
	function searchManage(){
		var  option= "width = 1000, height = 700, top = 100, left = 200"
			window.open('/receive/rcv01pop1','popup',option);
	}
	function receivePartnerData(item) { // 선택한곳에 거래처 보여주기
		$('#compCd').val(item.compCd);
		$('#compName').val(item.compName);
	}
	   
	   
	   
	$(document).ready(function() {
		$('#excelD').click(function() {
		excelDownload(searchform, '/useListExcel', 'useListExcel.xlsx');
			});
		});

</script>