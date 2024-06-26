<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="com.qms.user.vo.UserVO"%>
<%
UserVO uservo = (UserVO) session.getAttribute("QMSUser");
%>



<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>부서조회</title>
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

											<label for="inputText" class="col-sm-1 col-form-label">부서명</label>
											<div class="col-sm-2">
												<input type="text" class="form-control" id="deptName" name="deptName">
											</div>
											<label for="inputText" class="col-sm-2 col-form-label">삭제여부</label>
											<div class="col-sm-1">
												<select class="form-control" id = 'delYn' name ='delYn' style = "width: 76px;">
													<!-- DB 데이터 뿌리는 부분 -->
													<option value=''>선택</option>
													<option value='Y'>예</option>
													<option value='N'>아니오</option>
												</select>
											</div>

										</div>


									</td>
									<td rowspan="1">
										<button type="button" class="btn btn-info" onclick="deptSearch();">조회</button>
										<button type="button" class="btn btn-info" onclick="displayModal(0);">신규</button>
										<button type="button" class="btn btn-success" id="downloadBtn" >엑셀 다운로드</button>
									</td>
								</tr>

							</table>

						</form>

					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<!-- Table with hoverable rows -->
						<table class="table table-hover" id="deptTable">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">부서 ID</th>
									<th scope="col">부서명</th>
									<th scope="col">상위부서명</th>
									<th scope="col">할당사용자수</th>
									<th scope="col">삭제여부</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<!-- End Table with hoverable rows -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="deptPaging">

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

<div class="modal fade" id="deptInfo" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<strong>부서등록/수정</strong>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="dataform">

					<table class="table table-hover" id="deptDetailTable">
						<thead>
							<tr>
								<th scope="row">부서코드</th>
								<td><input type="text" class="form-control" id="mdeptCd" name="deptCd" maxlength="20"></td>
								<th scope="row">부서명</th>
								<td><input type="text" class="form-control" id="mdeptName" name="deptName"></td>
							</tr>
							<tr>
								<th scope="row">상위부서</th>
								<td>
								<select class="form-control" id="mupDeptCd" name="upDeptCd">
								<!-- DB 데이터 뿌려주는 부분 -->
								</select>
								</td>
								<th scope="row">삭제여부</th>
								<td>
								<select class="form-control" id="mdelYn" name="delYn"> 
										<option value=''>선택</option>
										<option value='Y'>예</option>
										<option value='N'>아니오</option>
								</select>
								</td>
							</tr>
						</thead>
						<tbody>
							<!-- DB 데이터 뿌려주는 부분 -->
						</tbody>
					</table>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="newSaveBtn" onclick="saveDept(1)">저장</button>
				<button type="button" class="btn btn-primary" id="UpdSaveBtn" onclick="saveDept(0)">저장</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
           

<!-- End Vertically centered Modal-->

<!--  form id="hiddenform">
	<input type="hidden" id="hitemCd" name="itemCd">
</form-->


<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>


<script>

	$(document).ready(function() {
		call_server(dataform, '/dept/upDeptName', disPlayUpdeptName);
	});
	
	function disPlayUpdeptName(list) {
	    $('#mupDeptCd').empty();
	    $('#mupDeptCd').append("<option value=''>선택</option>");

	    for (var i = 0; i < list.length; i++) {
	        var str = "<option value='" + list[i].deptCd + "'>" + list[i].deptName + "</option>";
	        $('#mupDeptCd').append(str);
	    }
	}



	function deptSearch(pno) {
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/dept/searchlist', getDeptlist);
	}

	function getDeptlist(vo) {
		$('#deptTable > tbody').empty();
		list = vo.deptlist;
		for (var i = 0; i < list.length; i++) {
			str = "<tr onclick=\"displayModal('" + list[i].deptCd + "');\" style=\"cursor:pointer;\">";
			str += "<th scope=\"row\">"	+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1)) + "</th>";
			str += "<td>" + list[i].deptCd + "</td>";
			str += "<td>" + list[i].deptName + "</td>";
			str += "<td>" + (list[i].upDeptName ? list[i].upDeptName : "최상위부서") + "</td>";
			str += "<td>" + list[i].userCount+ "</td>";
			str += "<td>" + list[i].delYn + "</td>";
			str += "<td>" + list[i].regDt + "</td>";
			str += "</tr>";
			$('#deptTable').append(str);
		}
		setPaging(deptPaging, vo.startPage, vo.endPage, 'deptSearch');
	}
	
	//---------이 밑부터 모달---------------	
	
	function displayModal(cd) {
    $('#dataform')[0].reset();
    if(cd != 0){
        $("#UpdSaveBtn").show();
        $("#newSaveBtn").hide();
        $("#mdeptCd").val(cd);
        console.log("Dept Code: ", cd);
        call_server(dataform, '/dept/getDeptDtlData', getDeptDtlData);
        $("#mdeptCd").prop("readonly", true);
    }else{
        $("#newSaveBtn").show();
        $("#UpdSaveBtn").hide();
        $("#mdeptCd").prop("readonly", false);
    }
	
    $('#deptInfo').modal('show');
    
	}
	
	function getDeptDtlData(vo) {
	    $("#mdeptName").val(vo.deptName);
	    $("#mdelYn").val(vo.delYn);
	    
	    if (!vo.upDeptCd && vo.upDeptCd == null) {
	        $("#mupDeptCd").val("최상위부서");
	    } else {
	        $("#mupDeptCd").val(vo.upDeptCd);
	    }
	}

	
	function saveDept(no) {
	    var valid = true; // valid 변수를 초기화

	    $('#dataform :input[name]').each(function() {
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
	    	call_server(dataform, '/dept/saveOrUpdateDept', complete);
		}
	}
	
	function complete(vo) {
		alert(vo.msg);
		location.reload();
		$('#deptInfo').modal('hide');
	}


   $(document).ready(function() {
          $('#downloadBtn').click(function() {
              excelDownload( searchform, '/dept/excelDownload', 'dept_data.xlsx');
          });
      });

   

		   
		    
		    
	
	

</script>