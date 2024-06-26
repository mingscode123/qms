<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>공지사항</title>
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
										<th>제목</th>
										<td><input type="text" style="width: 200px; height: 40px;" class="form-control" id="title" name="title"></td>
										<td>
										<th>공지종류</th>
										<td style="padding-left: 40px;"><select class="form-control" style="width: 90px; height: 40px;" id="noticeType" name="noticeType">
												<option value=''>선택</option>
										</select></td>
										<td><button type='button' class="btn btn-info" onclick="boardSearch();">조회</button>
											<button type='button' class="btn btn-success" onclick="newContent();">신규</button></td>

									</tr>
								</table>
							</div>

						</div>
					</div>
			</form>
			<div class="card">
				<div class="card-body">
					<!-- Table with hoverable rows -->
					<form id="detailform">
					<input type='hidden' id="noticeSeq" name="noticeSeq">
					</form>
					<table class="table table-hover" id="boardTable">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">공지종류</th>
								<th scope="col">제목</th>
								<th scope="col">부서</th>
								<th scope="col">작성자</th>
								<th scope="col">첨부파일</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					
					<!-- End Table with hoverable rows -->
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="noticePaging">

						</ul>
					</nav>

				</div>
			</div>
			
		</section>
	</main>
	<!-- End #main -->
	
	<!-- ======= Footer ======= -->
	<%@ include file="../layout/footer.jsp"%>

	<script src="/assets/js/common.js"></script>
	<script src="/assets/js/jquery-3.7.1.js"></script>
	<script src="/assets/js/paging.js"></script>

</body>
<script>
	function boardSearch(pno) {
		
		if (pno == undefined) {
			$('#currentPage').val(1);
		} else {
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/board/searchlist', contentList);

	}

	function contentList(vo) {

		list = vo.noticelist;
		$('#boardTable > tbody').empty();
		for (var i = 0; i < list.length; i++) {
			str = "<tr>";
			str += "<th scope=\"row\">"
					+ ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1))
					+ "</th>";
			str += "<td>" + list[i].comName + "</td>";
			str += "<td onclick=\"noticeDetail('"+list[i].noticeSeq+"');\" style=\"cursor:pointer;\">" + list[i].title + "</td>";
			str += "<td>" + list[i].deptName + "</td>";
			str += "<td>" + list[i].userName + "</td>";
			if (list[i].filePath != null && list[i].filePath != '') {
				str += "<td><a href='/download?filePath="+list[i].filePath+"&fileName="+list[i].fileName+"'><img src='/assets/img/filePicture.png' style='height:20px;'></a></td>";

			} else {
				str += "<td></td>";
			}
			str += "<td>" + list[i].regDt + "</td>";
			str += "</tr>";
			$('#boardTable > tbody').append(str);
		}
		setPaging(noticePaging, vo.startPage, vo.endPage, 'boardSearch');
	}
	function noticeDetail(seq){
		console.log(seq);
		//$('#noticeSeq').val(seq);
		
		var url = "/board/createContent?noticeSeq="+seq;
		var name = "공지사항 조회";
		var option = "width = 1000, height = 700, top = 100, left = 200"
		window.open(url, name, option);
		
		//call_server(detailform,'/board/noticeDetail', showDetail);
		
		//$('#noticeModal').modal('show');
	}
	function showDetail(vo){
		$('#ttitle').val(vo.title);
		$('#nnoticeType').val(vo.comName);
		$('#content').val(vo.content);
		$('#atcfile').val(vo.fileName);
	}
	
	
	function newContent() {
		var url = "/board/createContent";
		var name = "새 공지사항 추가";
		var option = "width = 1000, height = 700, top = 100, left = 200"
		window.open(url, name, option);
	}

	function init() {
		call_server(searchform, '/board/settingNotice', iinit);
	}
	function iinit(ntvo) {
		console.log(ntvo);
		list = ntvo.typelist;
		for (var i = 0; i < list.length; i++) {

			str = "<option value='"+list[i].comCd+"'>" + list[i].comName
					+ "</option>";
			$('#nnoticeType').append(str);
			$('#noticeType').append(str);
		}
	}
	init();
	
	
	
	
</script>
