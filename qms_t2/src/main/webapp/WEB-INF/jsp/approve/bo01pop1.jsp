<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

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


	
	<main id="main" class="main">

		<section class="section">
			<form id="dataform" enctype="multipart/form-data">
				<input type="hidden" name="noticeSeq" value="${vo.noticeSeq }">
				<div class="row">
					<div class="col-lg-12">

						<div class="card">
							<div class="card-body" style="padding-top: 20px;">
								<!-- General Form Elements -->


								<table class="table">
									<tr>
										<td style='width: 120px'>제목</td>
										<td><input type='text' class="form-control" id="title" name="title"></td>
									</tr>

									<tr>
										<td>공지종류</td>
										<td><select class="form-control" style="width: 100px; height: 40px;" id="noticeType" name="noticeType">
												<option value=''>선택</option>

										</select></td>
									</tr>

									<tr>
										<td>내용</td>
										<td>
											<div>
												<!-- Quill Editor Default -->
												<div class="quill-editor-default" id="content" name="content" style="height: 200px;"></div>
												
												<!-- End Quill Editor Default -->
											</div>
										</td>
									</tr>

									<tr>
										<td>첨부파일</td>
										<td><input type="file" id="atcfile" name="atcfile" class="form-control">
										    <div id='atcfileDiv'></div>
										</td>
									</tr>

								</table>

								<div style="display: flex; justify-content: center;">
									<button type="button" class="btn btn-primary" onclick="

									();">저장</button>
									<span>&nbsp;</span>
									<button type="button" class="btn btn-secondary" onclick="popUpclose();">닫기</button>
								</div>
							</div>
						</div>

					</div>
				</div>
				<input type = "hidden" id = "hcontent" name ="content"></input>
			</form>

		</section>
	</main>
	<!-- End #main -->

	<!-- Vendor JS Files -->
	<script src="/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/assets/vendor/quill/quill.min.js"></script>
	<script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/jquery-3.7.1.js"></script>
	<script src="/assets/js/common.js"></script>

	<!-- ======= Footer ======= -->

</body>
</html>
<script>
    // Quill 에디터 초기화
    var quill = new Quill('#content', {
    });

    function popUpclose() {
        window.close();
        //팝업 창 닫기
    }

    function saveNotice() {
    	
        // Quill 에디터의 내용을 가져옵니다.
        var quillContent = quill.root.innerHTML;
        // 가져온 내용을 숨겨진 input 요소의 값으로 설정합니다.
        $('#hcontent').val(quillContent);
        // 서버에 데이터를 전송하는 함수를 호출합니다.
        call_server(dataform, '/board/saveNotice', updateNotice);
    }

    function updateNotice(cnt) {
        if (cnt > 0) {
            alert("등록되었습니다.");
            window.close();
        } else {
            alert("실패하였습니다.");
        }
    }

    function init() {
        call_server(dataform, '/board/settingNotice', iinit);
    }

    function iinit(ntvo) {
		console.log(ntvo);
    	$('#title').val(ntvo.title);
    	if(ntvo.content!=null && ntvo.content!=''){
    		quill.setText(ntvo.content);
    	}
    	if(ntvo.fileName!=''){
    		
    	}
    	//$('#atcfile').val(ntvo.fileName);
    	;
    	$('#atcfileDiv').html("<a href='/download?filePath="+ntvo.filePath+"&fileName="+ntvo.fileName+"'><img src='/assets/img/filePicture.png' style='height:20px;'></a>");
		list = ntvo.typelist;
        for (var i = 0; i < list.length; i++) {
            str = "<option value='"+list[i].comCd+"'>" + list[i].comName + "</option>";
            $('#noticeType').append(str);
        }
        $('#noticeType').val(ntvo.noticeType);
    }

    init();
</script>