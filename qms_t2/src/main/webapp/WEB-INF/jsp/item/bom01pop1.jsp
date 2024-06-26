<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>재고조회</title>
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
							<input type='hidden' id='iyType' name='iyType' >
								<table class="col-lg-12">
								<tr>
								    <td>
								        <div class="row mb-3">
								            <label for="itemCd" class="col-sm-1 col-form-label">품번</label>
								            <div class="col-sm-2">
								                <input type="text" class="form-control" id="itemCd" name="itemCd">
								            </div>
								            
								            <label for="itemName" class="col-sm-1 col-form-label">품명</label>
								            <div class="col-sm-2">
								                <input type="text" class="form-control" id="itemName" name="itemName">
								            </div>
								        </div>
								    </td>
								    <td rowspan="3"  class="text-left">
								        <button type="button" class="btn btn-info" onclick="itemSearch();">조회</button>
								        <!-- button type="button" class="btn btn-info" onclick="itemUpDate();">등록</button-->
								    </td>
								</tr>
								</table>

							</form>
						</div>
					</div>
					<div class="card">
						<div class="card-body">
							<!-- Table with hoverable rows -->
							<table class="table table-hover"  id="itemTable" >
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">자재품번</th>
										<th scope="col">자재명</th>
										<th scope="col">제품(자재)유형</th>
										<th scope="col">단위</th>
										<th scope="col">BOX규격</th>
										<th scope="col">선택</th>
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

	function itemSearch(pno) {
		if(pno==undefined){
			$('#currentPage').val(1);	
		}else{
			$('#currentPage').val(pno);
		}
		call_server(searchform, '/item/searchlist', getItemlist);

	}
	
	function getItemlist(vo) {
		list = vo.itemlist;
		$('#itemTable > tbody').empty();
		for (var i = 0; i < list.length; i++) {
			str = "<tr>";
			str += "<th scope=\"row\">"+((Number(vo.currentPage)-1)*vo.countPerPage+(i+1))+"</th>";
			str += "<td>"+list[i].itemCd+"</td>";
			str += "<td>"+list[i].itemName+"</td>";	
			str += "<td>"+list[i].itemType+"</td>";	
			str += "<td>"+list[i].unitType+"</td>";
			str += "<td>"+list[i].boxType+"</td>";
			str += "<td><button type=\"button\" class=\"btn btn-primary\" onclick=\"chooseItem("+i+")\">선택</button></td>";
			str += "</tr>";
			$('#itemTable').append(str);
		}
		setPaging(itemPaging, vo.startPage, vo.endPage, 'itemSearch');
	
	}
	
	function chooseItem(idx) {
		
        if (window.opener && !window.opener.closed) {
            window.opener.receiveItemData(list[idx]);
            alert("등록완료");
            window.close();
        }
    }

</script>


