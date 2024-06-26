<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<%@ page import="com.qms.user.vo.UserVO"%>

<style>
#docNo, #docStatus {
	pointer-events: none;
	background-color: #f2f2f2;
	color: #999;
}
/*화려한 테이블 스타일 */
.fancy-table {
	border-collapse: collapse;
	width: 100%;
}

.fancy-table th, .fancy-table td {
	border: 1px solid #dddddd;
	padding: 12px;
	text-align: left;
}

.fancy-table th {
	background-color: #f0f0f0;
	color: #333;
}
</style>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title><spring:message code="menu.draftDocument" /></title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="/assets/img/favicon.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

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
		<form id="dataform" enctype="multipart/form-data">

			<div class="pagetitle">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="index.html"><spring:message code="menu.home" /></a></li>
						<li class="breadcrumb-item"><spring:message code="menu.eApproval" /></li>
						<li class="breadcrumb-item active"><spring:message code="menu.draftDocument" /></li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->
			<section class="section">
				<div class="container" style="background-color: white; padding: 20px; border-radius: 8px;">
					<div class="modal-body" style="display: flex; justify-content: space-between;">
						<div style="width: 49%;">
							<table class="fancy-table" style="table-layout: fixed; width: 100%;">
								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.number" /></th>
									<td style="width: 25%;">
										<input type='text' style="width: 90%;" readonly id="docNo">
									</td>
									<th scope="col" style="width: 10%;"><spring:message code="document.registrationDate" /></th>
									<td style="width: 25%;">
										<input type='text' style="width: 90%;" readonly id="regDt" name="regDt">
									</td>
								</tr>
								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.registrant" /></th>
									<td style="width: 25%;">
										<input type='text' style="width: 90%;" readonly id="userName" name="userName">
									</td>
									<th scope="col" style="width: 10%;"><spring:message code="document.department" /></th>
									<td style="width: 25%;">
										<input type='text' style="width: 90%;" readonly id="deptName" name="deptName">
									</td>
								</tr>
								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.documentType" /></th>
									<td style="width: 25%;">
										<select class="form-control" style="width: 90%;" id="docType" name="docType">
											<option value=""><spring:message code="message.selectAllFields" /></option>
										</select>
									</td>
									<th scope="col" style="width: 10%;"><spring:message code="document.preservationPeriod" /></th>
									<td style="width: 25%;">
										<select class="form-control" style="width: 90%;" id="preserveYear" name="preserveYear">
											<option value=""><spring:message code="message.selectAllFields" /></option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.documentCategory" /></th>
									<td style="width: 25%;">
										<select class="form-control" style="width: 90%;" id="docClass" name="docClass">
											<option value=""><spring:message code="message.selectAllFields" /></option>
										</select>
									</td>
									<th scope="col" style="width: 10%;"><spring:message code="document.documentStatus" /></th>
									<td style="width: 25%;">
										<select class="form-control" style="width: 90%;" id="docStatus">
											<option value=""><spring:message code="message.selectAllFields" /></option>
										</select>
									</td>
								</tr>
							</table>
							<br></br>
							<div>
								<h5 style="display: flex; justify-content: space-between;">
									<strong><spring:message code="line.approvalLine" /></strong>
									<button type="button" onclick="addLine();" style="border: 1px solid #f0f0f0; padding: 4px; border-radius: 10%; background-color: #f0f0f0; color: #666; font-size: 1.3em;">
										<div class="icon">
											<i class="ri-menu-add-line"></i>
										</div>
									</button>
								</h5>
								<div id="duplicateUserMessage" style="color: red; display: none;">
									<!-- 사용자를 중복 선택했을 경우 메세지가 뜨는 부분 -->
								</div>
							</div>
							<table class="fancy-table" id="lineTable">
								<thead>
									<tr>
										<th scope="col" style="width: 10%;">No</th>
										<th scope="col" style="width: 11%;"><spring:message code="line.name" /></th>
										<th scope="col" style="width: 11%;"><spring:message code="line.position" /></th>
										<th scope="col" style="width: 11%;"><spring:message code="line.department" /></th>
										<th scope="col" style="width: 11%;"><spring:message code="line.approvalType" /></th>
										<th scope="col" style="width: 11%;"><spring:message code="line.status" /></th>
										<th scope="col" style="width: 10%; justify-content: center;"><spring:message code="line.delete" /></th>
									</tr>
								</thead>
								<tbody id="userData">
									<!-- 팝업창에서 선택한 사용자 정보를 불러오는 부분 -->

								</tbody>
							</table>
							<br></br>
							<div>
								<h5 style="display: flex; justify-content: space-between;">
									<strong><spring:message code="file.attachment" /></strong> <label for="fileInput">
										<div class="icon">
											<i class="ri-folder-3-fill" style="border: 1px solid #f0f0f0; padding: 4px; border-radius: 10%; background-color: #f0f0f0; color: #666; font-size: 1.3em;"></i>
										</div>
									</label> <input id="fileInput" type="file" style="display: none;" class="form-control" multiple onchange="handleFileUpload();">
								</h5>
							</div>
							<table class="fancy-table">
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col"><spring:message code="file.fileName" /></th>
										<th scope="col"><spring:message code="file.fileSize" /></th>
										<th scope="col"><spring:message code="line.delete" /></th>
									</tr>
								</thead>
								<tbody id="fileTableBody">
								</tbody>
							</table>
						</div>

						<div class="separator" style="width: 1px; background-color: lightgray; margin: 10px;"></div>

						<div style="width: 49%;">
							<table class="fancy-table" style="table-layout: fixed; width: 100%;">
								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.title" /></th>
									<td style="width: 100%;">
										<input type='text' id="title" name="title" style="width: 100%;">
									</td>
								</tr>

								<tr>
									<th scope="col" style="width: 10%;"><spring:message code="document.description" /></th>
									<td colspan="3" style="width: 75%;">
										<textarea id="content" name="content" class="form-control" rows="20" style="width: 100%;"></textarea>
									</td>
								</tr>
							</table>
							<br>
							<div style="text-align: right;">
								<button type="button" class="btn btn-primary" onclick="submitDoc('02');">
									<spring:message code="button.submit" />
								</button>
								<button type="button" class="btn" onclick="submitDoc('01');" style="background-color: purple; color: white;">
									<spring:message code="button.saveDraft" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</section>

		</form>
	</main>
	<!-- End #main -->
	<!-- Pop up -->

	<!-- ======= Footer ======= -->
	<%@ include file="../layout/footer.jsp"%>


</body>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>
<script>
	$(document).ready(function() {
		//날짜데이터 생성
		function getFormattedDate() {
	        var date = new Date();
	        var year = date.getFullYear();
	        var month = ('0' + (date.getMonth() + 1)).slice(-2);
	        var day = ('0' + date.getDate()).slice(-2);
	        return year + '-' + month + '-' + day;
	    }
	    $('#regDt').val(getFormattedDate());
	    
		//셀랙트데이터 가져오기
		call_server(dataform, '/approve/getSelectData', getSelectData);
	});
	
	function getSelectData(vo){
		function appendOptions(list, selector) {
			$(selector).empty();
			$(selector).append("<option value=''>선택</option>");
			for (var i = 0; i < list.length; i++) {
				var str = "<option value='"+list[i].comCd+"'>"
				+ list[i].comName + "</option>";
	            $(selector).append(str);
	        }
	    }
		
		appendOptions(vo.doclist, '#docType');
	    appendOptions(vo.yearlist, '#preserveYear');
	    appendOptions(vo.classlist, '#docClass');
	    appendOptions(vo.statuslist, '#docStatus');
		
		$('#userName').val(vo.userName);
		$('#deptName').val(vo.deptName);

		//$('#docStatus').val('01');
		//$('#docStatus').prop('disabled', true);
		$("#docStatus").prop('readonly', true).val('01');
	}
	
	

	
	function addLine() {
		var url = "/approve/approveline";
		var name = "결재라인 추가";
		var option = "width = 900, height = 500, top = 100, left = 200"
		window.open(url, name, option);
	}


	var fileCount = 0;
	var fileNameArr = [];
	var totalFileSize = 0;
	
	function handleFileUpload(list) {
	    var fileInput = $('#fileInput');
	    var file = fileInput.prop('files')[0];
	    var fileSize = parseInt((file.size / 1024).toFixed(0)); // 파일 크기를 KB 단위로 변환
	    // 파일 이름 중복 확인
	    if (fileNameArr.includes(file.name)) {
	    	fileInput.val('');
	        alert("이미 첨부한 파일입니다.");
	        return;
	    }
	    if ((totalFileSize + fileSize) > 25600 ){
	    	fileInput.val('');
	    	alert("총 파일 크기가 25MB를 초과합니다.");
	    	return;
	    }
	    fileNameArr.push(file.name);
	    totalFileSize += fileSize;
	    fileCount++;

	    // 새로운 행을 생성
	    var newRow = "<tr id='row" + fileCount + "'>";
	    newRow += "<td class='file-number'>" + fileCount + "</td>";
	    newRow += "<td>" + file.name + "</td>";
	    newRow += "<td>" + fileSize + "KB</td>";
	    newRow += "<td><input type='file'  name='upfilelist[" + fileCount + "]'><button type='button' class='btn btn-danger delete-btn' onclick='deleteRow(\"row" + fileCount + "\");'>삭제</button></td>";
	    newRow += "</tr>";

	    // 테이블 본문에 새 행을 추가
	    $('#fileTableBody').append(newRow);

	    // 새로운 input 요소를 생성하여 현재 파일을 복사
	    var newFileInput = fileInput.clone();
	    newFileInput.attr('id', 'fileInput' + (fileCount-1));
	    newFileInput.attr('name', 'upfilelist[' + (fileCount-1) + ']');
	    newFileInput.prop('file', fileInput.prop('file'));
	    
	    // 새로 생성한 input 요소를 새로운 행에 추가
	    $('#row' + fileCount + ' input[type="file"]').replaceWith(newFileInput);
	    
	    // 원래의 input 요소 초기화
	    fileInput.val('');
	}

	function deleteRow(id) {
	    // 삭제할 파일의 이름 가져오기
	    var fileName = $('#' + id).find('td:nth-child(2)').text();
	    var fileSizeKB = $('#' + id).find('td:nth-child(3)').text();//KB가 아직 붙어있는 상태
	    var  fileSize = parseInt(fileSizeKB.replace('KB', ''));//KB를 제거하여 숫자의 형태로 변환
	    totalFileSize -= fileSize;
	    // fileNameArr 배열에서 해당 파일 이름 제거
	    var index = fileNameArr.indexOf(fileName);
	    if (index !== -1) {
	        fileNameArr.splice(index, 1);
	    }
	    
	    // 해당 행 삭제
	    $('#' + id).remove();
	    fileCount--;
	    updateFileNumbers();
	}

	function updateFileNumbers() {
	    var rows = $('#fileTableBody tr');
	    rows.each(function(index, row) {
	        $(row).find('.file-number').text(index + 1);
	        $(row).find('.file-number').text(index + 1);
	        $(row).find('input[type="file"]').attr('name', 'upfilelist[' + index + ']');
	    });
	}

	
	let selectedUsers = []; // 이미 선택한 사용자 목록을 저장하는 배열

    function receiveUserData(user) {
        // 팝업창에서 데이터를 보내면 이미 선택된 사용자인지 확인
        if (isUserSelected(user)) {
        	 displayDuplicateUserMessage(user.userName + "님은 이미 선택된 사용자입니다.");
            return; 
        } else {
        // 선택된 사용자 목록에 추가
        selectedUsers.push(user);

        // 테이블에 새로운 행 추가
        var rowIndex = selectedUsers.length;
        
        var html = "<tr class='deleteLow'>";
        html += "<td scope=\"row\" class='row-index'>" + rowIndex + "</td>";
        html += "<td><input type='hidden'  name='linelist["+ (rowIndex-1) +"].userId' value='"+user.userId+"'>" + user.userName + "</td>";
        html += "<td>" + user.comName + "</td>";
        html += "<td>" + user.deptName +  "</td>";
        html += "<td>결재</td>";
        html += "<td>대기</td>";
        html += "<td><button type=\"button\" class=\"btn btn-danger delete-btn\">삭제</button></td>";
        html += "</tr>";
        $('#userData').append(html);  // 새로운 데이터 추가
        
       }         
        

    }

	
    function isUserSelected(user) {
        // 이미 선택된 사용자 목록(selectedUsers)을 확인하여 사용자가 포함되어 있는지 확인
        for (let i = 0; i < selectedUsers.length; i++) {
            if (selectedUsers[i].userId === user.userId) {
                return true; 
            }
        }
        return false; 
    }
	
	function displayDuplicateUserMessage(message) {
    	//중복일때 메세지 호출
        $('#duplicateUserMessage').text(message).show();
    	
        setTimeout(function() {
            $('#duplicateUserMessage').hide();
        }, 5000); // 5초 후에 숨김
    }

    	
    // 삭제 버튼 클릭 이벤트 핸들러
    $(document).on('click', '#lineTable .delete-btn', function() {
        var row = $(this).closest('.deleteLow');
        var index = row.index(); // 행의 인덱스를 가져옴
        console.log(row);
        console.log(index);
        row.remove(); // 행 삭제

        // 선택된 사용자 목록에서 해당 사용자 제거
        selectedUsers.splice(index, 1);

        // 행 번호 재조정
        $('#userData tr').each(function(i) {
            $(this).find('.row-index').text(i + 1);
        });
    });
    
    

    function submitDoc(sta) {
        var valid = true; // 유효성 검사를 통과했는지 여부를 나타내는 변수
        
        // 폼 내의 모든 입력 요소를 순회하면서 유효성 검사 수행
        $('#dataform :input[name]').each(function() {
            var value = $(this).val().trim();
            if (!value) { // 값이 공백이거나 null인지 확인
                valid = false;
                return false; // 유효하지 않은 경우 반복문을 중단
            }
        });
        
        // 유효성 검사 실패 시 경고를 표시하고 서버 호출을 하지 않음
        if (!valid) {
            alert("모든 필드를 입력해주세요.");
            return;
        }
        
        // 사용자가 선택한 사용자가 있다면 서버 호출
        if (selectedUsers.length > 0) {
        	$('#docStatus').val(sta);
            call_server(dataform, '/approve/insertDocDate', insertDocDate);
        } else {
        	alert("결재라인을 추가해주세요.");
        }
    }
    
    function insertDocDate(result){
    	if(result>0){
    		alert("등록완료");
    		location.href = "/approve/list";
    	}
    }
    
  
	
	


</script>



