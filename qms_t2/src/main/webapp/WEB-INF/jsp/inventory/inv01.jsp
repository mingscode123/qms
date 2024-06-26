<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>재고조회</title>
<!-- Favicons -->
<link href="/assets/img/favicon.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
    rel="stylesheet">
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
</head>
<body>
<main id="main" class="main">
    <section class="section">
        <form id="searchform">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body" style="padding-top: 20px;">
                            <input type='hidden' id='currentPage' name='currentPage' value=1>
                            <table class="col-lg-12">
                                <tr>
                                    <th>년월</th>
                                    <td style="padding-left: 40px;">
                                        <select class="form-control" style="width: 90px; height: 40px;" id="inDtYear" name="inDtYear">
                                            <option value=''>==년==</option>
                                        </select>
                                    </td>
                                    <td style="padding-left: 40px;">
                                        <select class="form-control" style="width: 90px; height: 40px;" id="inDtMonth" name="inDtMonth">
                                            <option value=''>==월==</option>
                                            <option value='01'>01</option>
                                            <option value='02'>02</option>
                                            <option value='03'>03</option>
                                            <option value='04'>04</option>
                                            <option value='05'>05</option>
                                            <option value='06'>06</option>
                                            <option value='07'>07</option>
                                            <option value='08'>08</option>
                                            <option value='09'>09</option>
                                            <option value='10'>10</option>
                                            <option value='11'>11</option>
                                            <option value='12'>12</option>
                                        </select>
                                    </td>
                                    <th>품번</th>
                                    <td>
                                        <input type="text" style="width: 150px; height: 40px;" class="form-control" id="title" name="title">
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-info" onclick="invSearch();">조회</button>
                                        <button type="button" class="btn btn-success" id="downloadBtn">엑셀 다운로드</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <!-- Table with hoverable rows -->
                            <table class="table table-hover" id="listTable">
                                <thead>
                                    <tr id="listHeader">
                                        <th scope="col">No</th>
                                        <th scope="col">품번</th>
                                        <th scope="col">품명</th>
                                        <th scope="col">단위</th>
                                        <th scope="col">총재고수량</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <!-- End Table with hoverable rows -->
                            <nav aria-label="Page navigation example">
                                <ul class="pagination" id="invPaging">
                                </ul>
                            </nav>
                            <!-- End Pagination with icons -->
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
</main>
<script src="/assets/js/paging.js"></script>
<script src="/assets/js/jquery-3.7.1.js"></script>
<script src="/assets/js/common.js"></script>
<script>
    var now = new Date(); // 현재 날짜
    var year = now.getFullYear(); // 현재 년도
    var month = now.getMonth() + 1; // 현재 월
    var baseYear = ${baseYear}; // constant에서 가져온 baseYear

    for (var i = baseYear; i <= year; i++) {
        $('#inDtYear').append("<option value='" + i + "'>" + i + "</option>");
    }
    $('#inDtMonth').val(month < 10 ? '0' + month : month);
    $('#inDtYear').val(year);

    $(document).ready(function() {
        call_server(searchform, '/inventory/getLocation', setLocation);
    });    

    var locationlist; // 전역 변수로 location 정보를 담을 변수 선언

    function setLocation(list) {
        locationlist = list.locationlist; // 서버에서 받아온 location 정보를 변수에 할당

        var headerRow = $('#listHeader');
        for (var i = 0; i < locationlist.length; i++) {
            headerRow.append("<th>" + locationlist[i].comName + "</th>");
        }
    }
    
    function invSearch(pno) {
        if (pno === undefined) {
            $('#currentPage').val(1);
        } else {
            $('#currentPage').val(pno);
        }
        call_server(searchform, '/inventory/searchlist', getInvlist);
    }
    
    function getInvlist(vo) {
        $('#listTable > tbody').empty();  // 테이블 내용 초기화
        var list = vo.invlist;  // 재고 데이터 리스트
        
        var itemArr = [];
        
        for(var i=0;i<list.length;i++){
        	var isItem = false;
        	for(var j=0;j<itemArr.length;j++){
        		if(list[i].itemCd==itemArr[j]){
        			isItem = true;
        		}
        	}
        	if(!isItem){
        		itemArr.push(list[i].itemCd);
        	}
        }
    
        for(var i=0;i<itemArr.length;i++){
        	itemIdx = 0;
        	for(var j=0;j<list.length;j++){
        		if(itemArr[i]==list[j].itemCd){
	        		if(itemIdx==0){
	        			str = "<tr>";
	        			str += "<th scope=\"row\">" + ((Number(vo.currentPage) - 1) * vo.countPerPage + (i + 1)) + "</th>";
	        			str += "<td>" + list[j].itemCd + "</td>";
	                    str += "<td>" + list[j].itemName + "</td>";
	                    str += "<td>" + list[j].unitType + "</td>";
	                    str += "<td>" + getRowSum(list[j].itemCd, list) + "</td>";  // 각 품목의 총 재고 수량 계산
	                    for(var k=0;k<locationlist.length;k++){
	                    	str += "<td id='loc"+j+'_'+k+"'>-</td>";
	                    }
	        		}
        			itemIdx++;
        		}
        	}
        	str += "</tr>";
        	$('#listTable').append(str);
        	console.log(list);
        	for(var j=0;j<list.length;j++){
        		if(itemArr[i]==list[j].itemCd){
        			for(var k=0;k<locationlist.length;k++){
        				if(list[j].location==locationlist[k].comCd){
        					console.log(j+'-'+k+'>>'+list[j].itemCd + '--'+list[j].location + '--'+list[j].inQty);
        					$('#loc'+i+'_'+k).text(list[j].inQty);
        				}
        			}
        		}
        	}
        }
        
        setPaging(invPaging, vo.startPage, vo.endPage, 'invSearch');  
    }
    
    function getRowSum(itemCd, list) {
    	
        var sum = 0;
        for (var i = 0; i < list.length; i++) {
            if (list[i].itemCd === itemCd) {
            	sum += Number(list[i].inQty);
            }
        }
        return sum;
    }
    
    $(document).ready(function() {
        $('#downloadBtn').click(function() {
            excelDownload( searchform, '/inventory/excelDownload', 'inventory_data.xlsx');
        });
    });
    
</script>
</body>
</html>
