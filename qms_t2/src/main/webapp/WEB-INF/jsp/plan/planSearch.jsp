<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>생산계획보기</title>
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
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="mkPlanYear" name="mkPlanYear">
												<option value=''>==년==</option>
											</select></td>
											<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="mkPlanMonth" name="mkPlanMonth">
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

										<th>품번</th>
										<td>
										<input type="text" style="width: 150px; height: 40px;" class="form-control" id="itemCd" name="itemCd">
										</td>
										
										
										<td>
											<th>거래처</th>
										<td>
											<input type='hidden' id='compCd' name='compCd'>
											<input type="text" class="form-control" id="compName" name="compName" style = "wight:150px">
										</td>
										
										<td>
										<div class="icon" >
										<i class="ri-search-2-line" onclick="searchManage(1)"></i>
										<div class="label"></div></div></td>
										
										<td rowspan="1">
											<button type="button" class="btn btn-info" onclick="search(1);">조회
											</button>
											<button type="button" class="btn btn-info" id="planSearchExcel">엑셀
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
							<tr id="showDate" >
								
								
							</tr>
							</thead>
							
							<tbody>
							
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="mkPlanPaging">

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
		function receivePartnerData(item) { // 선택한곳에 거래처 보여주기
			$('#compCd').val(item.compCd);
			$('#compName').val(item.compName);
		}
		
		
		
		var now = new Date(); // 현재 날짜
		var year = now.getFullYear(); //현재 년도
		var month = now.getMonth()+1; //현재 월
		var baseYear = ${baseYear}; // constant에서 가져온baseYear
		
		
		
		str = "<td>NO</td>";
		str += "<td>거래처명</td>";
		str += "<td>품번</td>";
		str += "<td>품명</td>";
		str += "<td>SUM</td>";
		$('#showDate').append(str);
		
		
		
		for(var i=baseYear; i<=year; i++){
			$('#mkPlanYear').append("<option value='"+i+"'>"+i+"</option>"); // 헤더부분 셀렉단
		}
		if(month<10){
			$('#mkPlanMonth').val('0'+month); //헤더부분 현재년월로 세팅
		}else{
			$('#mkPlanMonth').val(month); //헤더부분 현재년월로 세팅
		}
		
		$('#mkPlanYear').val(year);
	
		function getLastDay(){
			var last = new Date($('#mkPlanYear').val(),$('#mkPlanMonth').val(),00); //year-month-마지막일
			var lastDate = last.getDate(); //마지막일
			return lastDate;
		}
		
	function search(pno){
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		
		$('#showDate').empty();
		$('#showDate').append("<th>NO</th>");
		$('#showDate').append("<th>거래처명</th>");
		$('#showDate').append("<th>품번</th>");
		$('#showDate').append("<th>품명</th>");
		$('#showDate').append("<th>SUM</th>");
		
		
		
		for(var i=1; i<=getLastDay(); i++){
			$('#showDate').append("<th>"+$('#mkPlanMonth').val()+"/"+i+"</th>");
		}
		
		call_server(searchform,'/plan/searchMkList',searchMkList);
	}
	function searchMkList(vo){
		$('#boardTable tbody').empty();
		list = vo.mkList;
		console.log(list);
		var keyValue = [];
		for(var i=0;i<list.length;i++){  
			isExist = false;
			for(var j=0;j<keyValue.length;j++){
				if( keyValue[j]==(list[i].compCd+"/"+list[i].itemCd)){
					isExist = true;
				}
			}
			if(!isExist){
				keyValue.push(list[i].compCd+"/"+list[i].itemCd); //push : 입력하겠다
			}
		} //list[i].compCd, list[i].itemCd 중 둘다 같지 않는 애들만 
		  //(list[i].compCd+"/"+list[i].itemCd)로 keyValue에 세팅 **둘다 중복인 애들을 걸러줌
		
		//==============TOTAL=======================
		str="<tr>";
		str+="<td colspan='4'>Total</td>";
		str+="<td>"+getTotal(list)+"</td>";  // SUM
		for(var k=1; k<=getLastDay(); k++){
			str+="<td>"+getDaySum(k, list)+"</td>";  // 일별 합계
		}
		str+="</tr>";
		$('#boardTable tbody').append(str);
		//========================================
		
		for(var i=0;i<keyValue.length;i++){
			str="<tr>";
			rowIdx = 0;
			for(var j=0;j<list.length;j++){
				if( keyValue[i]==(list[j].compCd+"/"+list[j].itemCd)){
					if(rowIdx==0){                  //No 부터 SUM까지 같은 애들만 1번 출력하기 위해 
						str+="<td>"+(j+1)+"</td>";
						str+="<td>"+list[j].compName+"</td>";
						str+="<td>"+list[j].itemCd+"</td>";
						str+="<td>"+list[j].itemName+"</td>";
						str+="<td>"+getItemSum(keyValue[i], list)+"</td>";
					}
					for(var k=1; k<=getLastDay(); k++){
						if(Number(list[j].planDt)==k){
							str+="<td>"+list[j].planQty +"</td>";
						}
					}

					rowIdx++;
				}
			}
			str+="</tr>";
			$('#boardTable tbody').append(str);
		}
		setPaging(mkPlanPaging, vo.startPage, vo.endPage, 'search');
	}
	
	function getItemSum(val, list){
		var s = val.split("/");
		var sum = 0;
		for(var i=0;i<list.length;i++){
			if(s[0]==list[i].compCd && s[1]==list[i].itemCd){
				sum+=Number(list[i].planQty);
			}
		}
		
		return sum;
	}
	
	function getDaySum(day, list){
		var sum = 0;
		for(var i=0;i<list.length;i++){
			if(Number(list[i].planDt)==day){
				sum+=Number(list[i].planQty);
			}
		}
		return sum;
	}
	
	function getTotal(list){
		var sum = 0;
		for(var i=0;i<list.length;i++){
			sum+=Number(list[i].planQty);
		}
		return sum;
	}
	
	$(document).ready(function() {
		$('#planSearchExcel').click(function() {
		excelDownload( searchform, '/planSearch/excelDownload', 'planSearch.xlsx');
			});
		});
	
</script>