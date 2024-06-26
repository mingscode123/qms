<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="com.qms.user.vo.UserVO"%>
<%
UserVO uservo = (UserVO) session.getAttribute("QMSUser");
%>



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
									<td>
										<div class="row mb-3">

											<label for="inputText" class="col-sm-1 col-form-label">품번</label>
											<div class="col-sm-2">
												<input type="text" class="form-control" id="itemCd" name="itemCd">
											</div>

											<label for="inputText" class="col-sm-1 col-form-label">품명</label>
											<div class="col-sm-2">
												<input type="text" class="form-control" id="itemName" name="itemName" >
											</div>
											<label for="inputText" class="col-sm-2 col-form-label">제품유형</label>
											<div class="col-sm-1">
												<select class="form-control" id="itemType" name="itemType" style = "width: 76px;">
													<!-- DB 데이터 뿌리는 부분 -->
												</select>
											</div>

										</div>


									</td>
									<td rowspan="1">
										<button type="button" class="btn btn-info" onclick="itemSearch();">조회</button>
										<button type="button" class="btn btn-info" onclick="displayModal(0);">신규</button>
										<button type="button" class="btn btn-info" id="downloadBtn" >엑셀 다운로드</button>
										<button type="button" class="btn btn-info" onclick="uploadBtn();" >엑셀 업로드</button>
									</td>
								</tr>

							</table>



						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="itemTable">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">품목코드</th>
									<th scope="col">품목명</th>
									<th scope="col">단위</th>
									<th scope="col">생산라인</th>
									<th scope="col">BOX 규격</th>
									<th scope="col">재고위치</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="itemPaging">

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

<div class="modal fade" id="itemInfo" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<strong>제품등록/수정</strong>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="dataform">

					<table class="table table-hover" id="itemDetailTable">
						<thead>
							<tr>
								<th scope="row">품번</th>
								<td><input type="text" class="form-control" id="mitemCd" name="itemCd" maxlength="20"></td>
								<th scope="row">품명</th>
								<td><input type="text" class="form-control" id="mitemName" name="itemName"></td>
							</tr>
							<tr>
								<th scope="row">제품유형</th>
								<td><select class="form-control" id="mitemType" name="itemType">
										<option value=''>선택</option>
								</select></td>
								<th scope="row">제품단위</th>
								<td><select class="form-control" id="munitType" name="unitType">
										<option value=''>선택</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">HSCODE</th>
								<td><input type="text" class="form-control" id="mhscode" name="hscode"></td>
								<th scope="row">BOX 규격</th>
								<td><select class="form-control" id="mboxType" name="boxType">
										<option value=''>선택</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">무게(g)</th>
								<td><input type="text" class="form-control" id="mweight" name="weight"></td>
								<th scope="row">BOX 수량</th>
								<td><input type="text" class="form-control" id="mboxQty" name="boxQty"></td>
							</tr>
							<tr>
								<th scope="row">생산라인</th>
								<td><select class="form-control" id="mplantLine" name="plantLine">
										<option value=''>선택</option>
								</select></td>
								<th scope="row">단가</th>
								<td><input type="text" class="form-control" id="munitPrice" name="unitPrice"></td>
							</tr>
							</tr>
							<tr>
								<th scope="row">재고위치</th>
								<td><select class="form-control" id="mlocation" name="location">
										<option value=''>선택</option>
								</select></td>
								<th scope="row">하도급여부</th>
								<td>
									<div class="form-check">
										<input type="checkbox" class="form-check-input" id="msubconYn"> 
										<label class="form-check-label" for="subconYn"></label>
										<input type="hidden" id="hsubconYn" name="subconYn" value="N">
									</div>
								</td>
						</thead>
						<tbody>
							<!-- DB 데이터 뿌려주는 부분 -->
						</tbody>
					</table>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="newSaveBtn" onclick="saveItem(1)">저장</button>
				<button type="button" class="btn btn-primary" id="UpdSaveBtn" onclick="saveItem(0)">저장</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
              <div class="modal fade" id="verticalycentered" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                  <form id = "excelform"enctype="multipart/form-data" >
                    <div class="modal-header">
                      <h5 class="modal-title">품목 엑셀 업로드</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                    <table>
                    <tr>
                    <th scope="row">엑셀파일</th>
					<td><input type="file" id="excelInput" name="excelInput" class="form-control">
				   <div id='atcfileDiv'></div>
					</td>
                    </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-primary" onclick = "realexcel();">엑셀 업로드</button>
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                    </form>
                  </div>
                </div>
              </div><!-- End Vertically centered Modal-->


<!-- End Vertically centered Modal-->

<form id="hiddenform">
	<input type="hidden" id="hitemCd" name="itemCd">
</form>


<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>
$(document).ready(function() {
	
    call_server(searchform, '/item/selectGetData', selectGetData);

    // 체크박스 변경 시 숨겨진 필드 값 변경
    $('#msubconYn').on('change', function() {
        if ($(this).is(':checked')) {
            $('#hsubconYn').val('Y');
        } else {
            $('#hsubconYn').val('N');
        }
    });

    // 여러 입력 필드에 대해 숫자만 입력 허용
    $('#mweight, #mboxQty, #munitPrice, #mhscode').on('input', function() {
        var inputVal = $(this).val();
        // 숫자만 남기고 다른 문자는 모두 제거
        $(this).val(inputVal.replace(/[^0-9]/g, ''));
    });
});

	
	function selectGetData(vo) {
	    function appendOptions(list, selector) {
	        $(selector).empty();
	        $(selector).append("<option value=''>선택</option>");
	        for (var i = 0; i < list.length; i++) {
	            var str = "<option value='" + list[i].comCd + "'>" + list[i].comName + "</option>";
	            $(selector).append(str);
	        }
	    }

	    appendOptions(vo.itemtypelist, '#itemType');
	    appendOptions(vo.itemtypelist, '#mitemType');
	    appendOptions(vo.unitlist, '#munitType');
	    appendOptions(vo.boxlist, '#mboxType');
	    appendOptions(vo.plantlist, '#mplantLine');
	    appendOptions(vo.locationlist, '#mlocation');
	}

	function itemSearch(pno) {
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/item/searchlist', getItemlist);
	}

	function getItemlist(vo) {
		$('#itemTable > tbody').empty();
		list = vo.itemlist;

		for (var i = 0; i < list.length; i++) {
			str = "<tr onclick=\"displayModal('" + list[i].itemCd
					+ "');\" style=\"cursor:pointer;\">";
			str += "<th scope=\"row\">"
					+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
					+ "</th>";
			str += "<td>" + list[i].itemCd + "</td>";
			str += "<td>" + list[i].itemName + "</td>";
			str += "<td>" + list[i].unitType + "</td>";
			str += "<td>" + list[i].plantLine + "</td>";
			str += "<td>" + list[i].boxType + "</td>";
			str += "<td>" + list[i].location + "</td>";
			str += "<td>" + list[i].regDt + "</td>";
			str += "</tr>";
			$('#itemTable').append(str);
		}
		setPaging(itemPaging, vo.startPage, vo.endPage, 'itemSearch');
	}
	
	//---------이 밑부터 모달---------------	
	
	function displayModal(cd) {//0이면 신규버튼으로 여는 모달 그 외에는 상품디테일모달
		$('#dataform')[0].reset();
		if(cd != 0){
			$("#UpdSaveBtn").show();
			$("#newSaveBtn").hide();
			$("#mitemCd").val(cd);
			call_server(dataform, '/item/getItemDtldata',getItemDtldata );
			$("#mitemCd").prop("readonly", true);
		}else{
			$("#newSaveBtn").show();
			$("#UpdSaveBtn").hide();
			$("#mitemCd").prop("readonly", false);
		}
	
		
	    $('#itemInfo').modal('show');
	}
	
	function getItemDtldata(vo){
		$("#munitType").val(vo.unitType);
		$("#mitemName").val(vo.itemName);
		$("#mitemType").val(vo.itemType);
		$("#mhscode").val(vo.hscode);
		$("#mboxType").val(vo.boxType);
		$("#mweight").val(vo.weight);
		$("#mboxQty").val(vo.boxQty);
		$("#mplantLine").val(vo.plantLine);
		$("#munitPrice").val(vo.unitPrice);
		$("#mlocation").val(vo.location);
		
		var yn = vo.subconYn;
		if( yn == "Y"){
			$("#msubconYn").prop("checked", true);
		} else {
		    $("#msubconYn").prop("checked", false);
		}
	}
	
	
	
	function saveItem(no) { // no가 1이면 신규저장, 0이면 수정저장
	    var valid = true; // valid 변수를 초기화

	    // subconYn 필드를 제외하고 모든 입력 필드를 검사
	    $('#dataform :input[name]').not('[name="subconYn"]').each(function() {
	        var value = $(this).val().trim();
	        if (!value) { // 값이 공백이거나 null인지 확인
	            valid = false;
	            return false; // 유효하지 않은 경우 반복문을 중단
	        }
	    });

	    if (valid == false) {
	        alert("모든 필드를 입력해주세요.");
	        return;
	    } else {
	        if (no == 1) {
	            call_server(dataform, '/item/saveItem', complete);
	        } else {
	            call_server(dataform, '/item/updateItem', complete);
	        }
	    }
	}
	
	function complete(vo) {
		alert(vo.msg);		
		$('#itemInfo').modal('hide');
	}


   $(document).ready(function() {
          $('#downloadBtn').click(function() {
              excelDownload( searchform, '/item/excelDownload', 'item_data.xlsx');
          });
      });

   
  // ======================= 엑셀파일
  
   function uploadBtn(){ // 엑셀 업로드 버튼 클릭시 모달
	   $('#verticalycentered').modal('show');
   }
   
	   function checkFileType(filePath){ // 파일이 엑셀파일이 맞는지 검증
		  var fileFormat = filePath.split("."); 
		  if(fileFormat.indexOf("xls") >-1 || fileFormat.indexOf("xlsx") > -1){
		  return true;
		    }else{
		      return false;
		       }
	  }
	    function realexcel() { // 파일이 엑셀파일이 맞으면 callserver
	      var file = document.getElementById('excelInput').value;
		      if(file == "" || file == null ){
		      alert('파일을 선택해주세요.');
		       return false;
		      }else if(!checkFileType(file)){
		       alert('엑셀 파일만 업로드 가능합니다.');
		         $("#excelUploadForm")[0].reset();
		          return false;
		      }
	          if(confirm("업로드 하시겠습니까?")){
	  		 		call_server(excelform, '/excelupload', excelupload);
	  			}
	   }
	   function excelupload(cnt){ // 엑셀파일 등록완료
		   if (cnt > 0 ) {
			    alert("등록완료");
			    $('#verticalycentered').modal('hide');
			    itemSearch();
			} else {
			    alert("실패");
			}
		}
		   
		    
		    
	
	

</script>