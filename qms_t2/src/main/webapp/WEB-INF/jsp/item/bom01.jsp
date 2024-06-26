<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>BOM 조회</title>
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
    <script src="/assets/js/common.js"></script>
  <script src="/assets/js/jquery-3.7.1.js"></script>

</head>

<body>

  <%@ include file="../layout/menu.jsp" %>

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
									 <td style="width:80px;">
                      				<label for="goodsName" class="col-sm-4 col-form-label">품번</label>
               						   </td>
                 					 <td style="width:200px;">
                    			  <input type="text" class="form-control" id="itemCd" name="itemCd">
                  					</td>
									<td style="width:80px;">
                      				<label for="goodsName" class="col-sm-2 col-form-label">품명</label>
               						   </td>
                 					 <td style="width:200px;">
                    			  <input type="text" class="form-control" id="itemName" name="itemName">
                  					</td>
									<td style="width:200px;">
                       				<select class="form-control" id="itemType" name="itemType">
                        			 <option value=''>선택</option>
                     				  </select>
                  					</td>
									
									<td rowspan="2">
										<button type="button" class="btn btn-info" onclick="BomSearch();">조회</button>
										<button type="button" class="btn btn-info" onclick="newOrder();">신규</button>
									</td>
								</tr>
							</table>



						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						
						<table class="table table-hover" id="bomListTable">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">품목코드</th>
									<th scope="col">품목명</th>
									<th scope="col">Box단위</th>
									<th scope="col">생산라인</th>
									<th scope="col">Box규격</th>
									<th scope="col">재료수</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="BomPaging">
								
							</ul>
						</nav>
						<!-- End Pagination with icons -->

					</div>
				</div>
			</div>
		</div>
	</section>
</main>

<div class="modal fade" id="bomDtlInfo" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">BOM 등록/수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
			<form id="modalform">
			<input type="hidden" id="iutype" name="iutype">
				<table class="table table-hover" id="productOrderingDetailTable">
					<thead>
						<tr>
							<th scope="row">품번</th>
							<td>
							<input type="text" class="form-control" id="itCd" name="itemCd">
							</td>
							<th scope="row">품명</th>
							<td>
							<input type="text" class="form-control" id="itName" name="itemName">
							</td>
							<td><button type="button" class="btn btn-primary" onclick="searchit()">조회</button>
							    <button type="button" class="btn btn-info" onclick="itemUpDate();">등록</button></td>
						</tr>
						<tr>
						<td colspan='5' style="text-align: right;">
     					 <button type="button" class="btn btn-primary" onclick="addButton()">+</button>
   						 </td>
						</tr>
					</thead>
					</table>
					<table class="table table-hover" id="BomSelectT">
					<tbody>
					<tr>
							<th scope="col">자재품번</th>
							<th scope="col">자재명</th>
							<th scope="row">BOM LEVEL</th>
							<th scope="col">재품(자재)유형</th>
							<th scope="col">투입수량</th>
							<th scope="col">단위</th>
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
	<input type="hidden" id="temCd" name="itemCd">
</form>


<script src="/assets/js/paging.js"></script> 
<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>

<script>
function BomSearch(){
	call_server(searchform,'/selectBomList',selectBomList);
}
function selectBomList(vo){
	list = vo.bomlist;
	console.log(vo);
	$('#bomListTable > tbody').empty();
	for(var i=0;i<list.length;i++){
		$('#itCd').val(list[i].itemCd);
	    $('#itName').val(list[i].itemName);
		str="<tr onclick=\"bomDetail('"+list[i].itemCd+"','"+list[i].itemName+"');\" style=\"cursor:pointer;\">";
		str+="<th scope=\"row\">"+((Number(vo.currentPage)-1)*vo.countPerPage+(i+1))+"</th>";
		str+="<td>"+list[i].itemCd+"</td>";
		str+="<td>"+list[i].itemName+"</td>";
		str+="<td>"+list[i].unitType+"</td>";
		str+="<td>"+list[i].plantLine+"</td>";
		str+="<td>"+list[i].boxType+"</td>";
		str+="<td>"+list[i].bomCnt+"</td>";
		str+="<td>"+list[i].regDt+"</td>"; 
		str+="</tr>";
		$('#bomListTable tbody').append(str);	
	}
	setPaging(BomPaging, vo.startPage, vo.endPage, 'BomSearch');
}

function init(){
	call_server(searchform,'/selectItemCode',setData);
}

function setData(list){
	for(var i=0;i<list.length;i++){
		str="<option value='"+list[i].comCd+"'>"+list[i].comName+"</option>";
		$('#itemType').append(str);
	}
}
init();

function bomDetail(cd,nm){
	$('#itCd').val(cd);
	$('#temCd').val(cd);
	$('#itName').val(nm);
	call_server(hiddenform,'/selectBomDtlList',BomDtlList);
}

function BomDtlList(list){
	$('#BomSelectT > tbody').empty();
	for(var i = 0; i < list.length; i++){
	    setRowData(list[i]);
	}
	$('#bomDtlInfo').modal('show');
}
		
function addButton(){
	setRowData(null);
}

function delTr(obj){
	$(obj).closest('tr').remove();
}
function searchit(){
	call_server(modalform,'/selectBomDtlList',selectItBList);
}

function selectItBList(vo){
	console.log(vo);
	$('#itCd').val(vo.itemCd);
    $('#itName').val(vo.itemName);
	list = vo.bomDtlList;
	cnt = list.length;
	cct = list.length;
	$('#BomSelectT > tbody').empty();
	if(list!=null){
		for(var i = 0; i < list.length; i++){
			setRowData(list[i]);
	    }
	}
}
var activeRow = 0;
function additem(no){
	activeRow = no;
	var  option= "width = 1000, height = 700, top = 100, left = 200"
	window.open('/item/bom01pop1','popup',option);
}

function itemUpDate(){
	call_server(modalform,'/itemDelInsertAdd',itemDelInsertAdd);
}
function itemDelInsertAdd(cnt){
	if (cnt > 0 ) {
	    alert("등록완료");
	    $('#bomDtlInfo').modal('hide');
	    BomSearch();
	} else {
	    alert("실패");
	}
}
function newOrder(){
	$('#bomDtlInfo').modal('show');
}
function receiveItemData(item) {
	$('#addCd'+activeRow).val(item.itemCd);
	$('#addNm'+activeRow).val(item.itemName);
	$('#itType'+activeRow).val(item.itemType);
	$('#unitType'+activeRow).val(item.unitType);
}
	

var rowidx=0;
function setRowData(vo){
	if(vo==null){
		vo = new Object();
		vo.sitemCd='';
		vo.sitemName='';
		vo.itemType='';
		vo.insQty = '';
		vo.unitType='';
	}else{
		console.log(vo);
	}
	str= "<tr>";
    str+= "<td><input type=\"text\" id=\"addCd"+rowidx+"\" name=\"itemlist["+rowidx+"].sitemCd\" value='"+vo.sitemCd+"'class=\"form-control\">";
    str += "<div class=\"icon\" >";
	str += "<i class=\"ri-search-2-line\"onclick=\"additem("+rowidx+")\"></i>";
	str += "<div class=\"label\"></div>";
	str += "</div>";
    str+= "</td>";
    str+= "<td><input type=\"text\" id=\"addNm"+rowidx+"\" value='"+vo.sitemName+"'class=\"form-control\"></td>";
    str+=  "<td ><select id=\"bomLevel"+rowidx+"\" name=\"itemlist["+rowidx+"].bomLevel\"style=\"width:200px;\"class=\"form-control\"><option value=>== 선택 ==</option><option value=\"1\">1</option><option value=\"2\">2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option></select></td>";
    str+=  "<td class=\"form-control\"><input type='text' id=\"itType"+rowidx+"\" value='"+vo.itemType+"'></td>";
    str+= "<td><input type=\"text\" name=\"itemlist["+rowidx+"].insQty\" value='"+vo.insQty+"'class=\"form-control\"></td>";
    str+=  "<td><input type=\"text\" id=\"unitType"+rowidx+"\" value='"+vo.unitType+"'></td>";
    str+=  "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"delTr(this)\">삭제</button></td>"; 
    str+=  "</tr>";
    $('#BomSelectT').append(str);
    $('#bomLevel'+rowidx).val(vo.bomLevel);
    rowidx++;
	
}


</script>
 <script src="/assets/js/paging.js"></script> 
 