<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>거래처조회</title>
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
<style>
    .mb-3 .col-sm-2 {
        margin-right: 5px; /* 필요한 경우 margin 값 조정 */
    }
</style>
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
								    <td>
								        <div class="row mb-3">
								            <label for="itemCd" class="col-sm-1 col-form-label" style='width: 120px'>거래처코드</label>
								            <div class="col-sm-2">
								                <input type="text" class="form-control" id="compCd" name="compCd">
								            </div>
								            
								            <label for="itemName" class="col-sm-1 col-form-label" style='width: 120px'>거래처명</label>
								            <div class="col-sm-2">
								                <input type="text" class="form-control" id="compName" name="compName">
								            </div>
								        </div>
								    </td>
								    <td rowspan="3"  class="text-left">
								        <button type="button" class="btn btn-info" onclick="partnerSearch();">조회</button>
								    </td>
								</tr>
								</table>

							</form>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<!-- Table with hoverable rows -->
							<table class="table table-hover"  id="partnerTable" >
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">거래처코드</th>
										<th scope="col">거래처명</th>
										<th scope="col">대표자명</th>
										<th scope="col">사업번호</th>
										<th scope="col">연락처명</th>
										<th scope="col">선택</th>
									</tr>
								</thead>
								<tbody>


								</tbody>
							</table>
							<!-- End Table with hoverable rows -->
							<nav aria-label="Page navigation example">
								<ul class="pagination" id="partenerPaging">
								
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

	function partnerSearch(pno) {
		if(pno==undefined){
			$('#currentPage').val(1);	
		}else{	
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/partner/searchlist', getPartnerlist);

	}
	
	function getPartnerlist(vo) {
		list = vo.partnerlist;
		$('#partnerTable > tbody').empty();
		for (var i = 0; i < list.length; i++) {
			str = "<tr>";
			str += "<th scope=\"row\">"+((Number(vo.currentPage)-1)*vo.countPerPage+(i+1))+"</th>";
			str += "<td>"+list[i].compCd+"</td>";
			str += "<td>"+list[i].compName+"</td>";	
			str += "<td>"+list[i].compCeo+"</td>";	
			str += "<td>"+list[i].bizNo+"</td>";
			str += "<td>"+list[i].phone+"</td>";
			str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"choosePartner("+i+")\">선택</button></td>";
			str += "</tr>";
			$('#partnerTable').append(str);
		}
		setPaging(partenerPaging, vo.startPage, vo.endPage, 'partnerSearch');
	
	}
	
	function choosePartner(idx) {
		
        if (window.opener && !window.opener.closed) {
            window.opener.receivePartnerData(list[idx]);
            window.close();
        }
    }

</script>


