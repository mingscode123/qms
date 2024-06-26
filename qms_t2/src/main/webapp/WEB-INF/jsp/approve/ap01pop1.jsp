<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>기안서 작성</title>
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
									 <td style="text-align: center; width:146px;" >
                      				<label for="userName" class="col-sm-4 col-form-label">회원명</label>
               						   </td>
                 					 <td style="width:100px;">
                    			  <input type="text" class="form-control" id="userName" name="userName">
                  					</td>
									<td rowspan="2">
									   <button type="button" class="btn btn-info" onclick="userSearch();">조회</button>
									   <button type="button" class="btn btn-info" id="downloadBtn">엑셀 다운로드</button>
									</td>
								</tr>
						
								</table>

							</form>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<!-- Table with hoverable rows -->
							<table class="table table-hover"  id="userTable" >
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">성명</th>
										<th scope="col">부서</th>
										<th scope="col">직위</th>
										<th scope="col">퇴사여부</th>
										<th scope="col">선택</th>
									</tr>
								</thead>
								<tbody>

									



								</tbody>
							</table>
							<!-- End Table with hoverable rows -->
							<nav aria-label="Page navigation example">
								<ul class="pagination" id="userPaging">
								
								</ul>
							</nav>


						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->
	<!-- Pop up -->




	<!-- ======= Footer ======= -->


</body>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>
<script src="/assets/js/paging.js"></script> 

<script>
	
	function userSearch(pno) {
		if(pno==undefined){
			$('#currentPage').val(1);	
		}else{
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/user/searchlist', getUserList);

	}
	
	function getUserList(vo) {
		list = vo.userlist;
		$('#userTable > tbody').empty();
		for (var i = 0; i < list.length; i++) {
			
				str = "<tr>";
				str += "<th scope=\"row\">"+((Number(vo.currentPage)-1)*vo.countPerPage+(i+1))+"</th>";
				str += "<td>" + list[i].userName + "</td>";
				str += "<td>" + list[i].deptName + "</td>";
				str += "<td>" + list[i].comName + "</td>";
				str += "<td>" + list[i].leaveYn + "</td>";
				if( list[i].leaveYn == "N" ){
					str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"chooseUser("+i+")\">선택</button></td>";
				}else{
					str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"chooseUser("+i+")\" disabled>선택</button></td>";
				}
					str += "</tr>";
				$('#userTable').append(str);
		}
		setPaging(userPaging, vo.startPage, vo.endPage, 'userSearch');
	
	}
	
	$(document).ready(function() {
	    $('#downloadBtn').click(function() {
	    	excelDownload(searchform, '/user/excelDownload', 'user_data.xlsx');
	    });
	}); //엑셀 다운로드 함수 

	
	function chooseUser(idx) {
		
        if (window.opener && !window.opener.closed) {
            window.opener.receiveUserData(list[idx]);
            //window.close(); 팝업창은 사용자가 수동으로 끄되 , 결재라인에 등록할 사용자를 원하는만큼 선택할수 있도록 변경함.
        }
    }

</script>


