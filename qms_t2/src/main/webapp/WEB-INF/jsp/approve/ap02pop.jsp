<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
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
<style>
    body {
      font-family: 'Nunito', sans-serif;
      background-color: #f0f2f5;
      font-size: 16px;
    }

    .container {
      max-width: 1600px;
      margin: auto;
      padding: 20px;
    }

    .pagetitle {
      margin-bottom: 20px;
      font-size: 24px;
      font-weight: 700;
      color: #333;
    }

    .breadcrumb {
      background-color: transparent;
      padding: 0;
      margin-bottom: 20px;
    }

    .breadcrumb-item + .breadcrumb-item::before {
      content: ">";
      color: #6c757d;
    }

    .section {
      background-color: #ffffff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    #full {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    #screen_left,
    #screen_right {
      flex: 1;
      min-width: 500px;
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    table {
      width: 100%;
      margin-bottom: 20px;
      border-collapse: collapse;
    }

    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #dee2e6;
    }

    th {
      background-color: #f1f1f1;
    }

    .input-box {
      width: 100%;
      padding: 8px;
      border: 1px solid #ced4da;
      border-radius: 4px;
    }

    select, textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ced4da;
      border-radius: 4px;
    }

    textarea {
      resize: vertical;
    }

    .btn {
      margin-right: 10px;
    }

    .btn-info {
      background-color: #17a2b8;
      border-color: #17a2b8;
      color: white;
    }

    .btn-info:hover {
      background-color: #138496;
      border-color: #117a8b;
    }

    .table-section {
      margin-bottom: 20px;
    }

    .table-section table {
      margin-bottom: 0;
    }
  </style>
<link href="/assets/css/style.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>기안서 상세</title>
</head>
<body>
<div class="row">
      <div class="col-lg-12">
      <form id = "searchform">
        <div class="card">
          <div class="card-body" style="padding-top: 20px;">
             <h5 class="card-title">기안서 상세</h5>
           </div>
           <div class="modal-body">
           <table>
           <tr>
           <td>
             <table class="table table-hover"  id = "DetailTable" >
                <thead>
                  <tr>
                    <th scope="col">문서번호</th>
                    <td id = "docNo"></td>
                    <th scope="col">등록일</th>
                    <td id = "regDt"></td>
                    </tr>
                    <tr>
                    <th scope="col">등록자</th>
                    <td id = "userName"></td>
                    <th scope="col">부서</th>
                    <td id = "deptName"></td>
                    </tr>
                    <tr>
                    <th scope="col">문서유형</th>
                    <td id = "docType"></td>
                    <th scope="col">보존년한</th>
                    <td id = "preserveYear"></td>
                    </tr>
                    <tr>
                    <th scope="col">문서종류</th>    
                    <td id = "docClass"></td>     
                    <th scope="col">문서상태</th>
                    <td id = "docStatus"></td>                       
                    </tr>
                </thead>
           		<tbody>
           		</tbody>
              </table>
               <div class="card">
           <div class="card-body">
              <table id = "paymentLine">
               <h5><strong>결재라인</strong></h5>
              <tr>
                    <th scope="col">No</th>
                    <th scope="col">성명</th>
                    <th scope="col">직위</th>
                    <th scope="col">부서</th>
                    <th scope="col">결재유형</th>
                    <th scope="col">상태</th>
             </tr>
              </table>
              <hr>
              <table id = "aprvFileT">
              <h5><strong>첨부파일</strong></h5>
              <tr>
                    <th scope="col">No</th>
                    <th scope="col">파일명</th>
                    <th scope="col">파일크기(Kbyte)</th>
             </tr>
              </table>
              </div>
           <div class="card-footer">
              
              </div>
              </div>
              </td>
              <td>
              
              <table>
              <tr>
              <th scope="col">제목 :</th>
              <td><input type = "text" id="title"></td>
              </tr>
              <tr>
              <th scope="col">내용</th>
              <td id='content' style="height:500px;vertical-align: top;"><!--textarea id="content" rows="20" cols="60"></textarea--></td>
              </tr>
             </table>
             </td>
             </tr>
             </table>
             </div>
              <div class="card-footer">
              <button type="button" class="btn btn-info" onclick = 'orderee(0);' id="btnAprv">결재</button>
              <button type="button" class="btn btn-danger" onclick = 'orderee(1);' id="btnReject">반려</button>
           </div>
              </div>
               </form>
              </div>
              </div>
<div class="modal fade" id="agree" tabindex="-1">
       <div class="modal-dialog modal-l modal-dialog-centered">
         <div class="modal-content">
         <form id = "modalform">
         <input type = "hidden" id = "iutypea" name = "iutype">
         <input type = "hidden" id = "ouserId" name = "userId">
         <input type = "hidden" id = "odocNo" name = "docNo">
           <div class="modal-header">
             <h5 class="modal-title">결재</h5>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
           </div>
           <div class="modal-body">
             <table class="table table-hover"  border=1>
             <h3>결재의견</h3>
             <div class="modal-footer">
             <textarea id="replyContent" name = "opinion" rows="2" cols="30"></textarea>
             <button type="button" class="btn btn-info" onclick='order();'>결재</button>
             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
             </div>
             </table>
             </div>
             </form>
             </div>
             </div>
             </div>
             
             <div class="modal fade" id="passing" tabindex="-1">
       <div class="modal-dialog modal-l modal-dialog-centered">
         <div class="modal-content">
         <form id = "modalform1">
         <input type = "hidden" id = "iutypep" name = "iutype">
         <input type = "hidden" id = "puserId" name = "userId">
         <input type = "hidden" id = "pdocNo" name = "docNo">
           <div class="modal-header">
             <h5 class="modal-title">반려</h5>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
           </div>
           <div class="modal-body">
             <table class="table table-hover"  border=1>
             <h3>반려의견</h3>
             <div class="modal-footer">
             <textarea id="replyContent1"  name = "opinion" rows="2" cols="30"></textarea>
             <button type="button" class="btn btn-info" onclick='order();'>반려</button>
             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
             </div>
             </table>
             </div>
             </form>
             </div>
             </div>
             </div>
</body>
<form id = "hiddenform">
<input type='hidden' id='docNo' name='docNo' value='${vo.docNo}'>
</form>
<script src="/assets/js/common.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>



<script>
call_server(hiddenform,'/getDocDetail',getDocDetail);

function getDocDetail(vo){
	$('#odocNo').val(vo.docNo);
	$('#pdocNo').val(vo.docNo);
	$('#ouserId').val(vo.aprvUserId);
	$('#puserId').val(vo.aprvUserId);
	
	$('#docNo').text(vo.docNo);
	$('#userName').text(vo.userName);
	$('#docType').text(vo.docTypeName);
	$('#docClass').text(vo.docClassName);
	$('#regDt').text(vo.regDt);
	$('#deptName').text(vo.deptName);
	$('#preserveYear').text(vo.preserveYearName);
	$('#docStatus').text(vo.docStatusName);
	$('#title').val(vo.title);
	$('#content').text(vo.content);
	
	for(var i=0;i<vo.linelist.length;i++){
		str="<tr>"
		str+="<td>"+(i+1)+"</td>";
		str+="<td>"+vo.linelist[i].userName+"</td>";
		str+="<td>"+vo.linelist[i].positionCdName+"</td>"; 
		str+="<td>"+vo.linelist[i].deptName+"</td>";
		str+="<td>"+vo.linelist[i].aprvTypeName+"</td>";
		str+="<td>"+vo.linelist[i].aprvStatusName+"</td>";
		str+="</tr>";
		$('#paymentLine').append(str);
	}
	var fileSize = (vo.filelist[i].fileSize / 1024).toFixed(2) + ' KB';
	for(var i=0;i<vo.filelist.length;i++){
		str="<tr>"
		str+="<td>"+(i+1)+"</td>";
		str+="<td>"+vo.filelist[i].fileName+"</td>";
		str+="<td>"+fileSize+"</td>"; 
		str+="</tr>";
		$('#aprvFileT').append(str);
	}
	console.log(vo);
	if(!vo.aprv){
		$('#btnAprv').prop("disabled",true);
		$('#btnReject').prop("disabled",true);
	}
}
function orderee(obj){
	if(obj == 0){
		$('#iutypea').val('a');
		$('#agree').modal('show');
	}else{
		$('#iutypep').val('p');
		$('#passing').modal('show');
	}
}
function order(){
		
 		 var iutypeaValue = $('#iutypea').val();
		 var iutypepValue = $('#iutypep').val();
	if(iutypeaValue == 'a'){
		$('#replyContent').val();
		call_server(modalform,'/UpdateStatus',UpdateStatus);
	}else if(iutypepValue == 'p'){
		$('#replyContent1').val();
		call_server(modalform1,'/UpdateStatus',UpdateStatus);
	}
}
function UpdateStatus(cnt){
	if(cnt>0){
		alert('결제완료');
		$('#agree').modal('hide');
		$('#passing').modal('hide');
	}else{
		alert("등록실패");
	}
}








</script>




</html>



