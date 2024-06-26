function getTimeZoneOffset(){
 	var date = new Date();
	var offset = date.getTimezoneOffset();
	return offset;
}

function getLocalTimeZone(){
	return Intl.DateTimeFormat().resolvedOptions().timeZone;	
}


function call_server(f,url, cbFunc){
	var formData = new FormData($(f)[0]);
	//console.log(formData);
	$.ajax({
			data : formData,
			type : "POST",
			url : url,
			cache : false,
			processData: false,
			contentType: false,
			success : function(data) {
				if(data){
					cbFunc(data);
				}else{
					alert("오류가 발생하였습니다.");
				}
		    }
		});
		
	
}

function excelDownload(f , url, filename) {
     var formData = new FormData($(f)[0]);
         console.log(formData , url, filename);
    $.ajax({
        data : formData,
        url: url,
        type: 'POST',
        cache: false,
        processData: false, 
        contentType: false, 
        xhrFields: {
            responseType: 'blob'
        },
        success: function(response) {
            var blob = new Blob([response], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = filename;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
        },
        error: function(xhr, status, error) {
            console.error('Error: ' + error);
        }
    });
}

function alertShow(obj){
	$(obj).show();
}

function alertClose(obj){
	$(obj).hide();
}

function addComma(value){
	if(value==undefined || value=='' || value==null){
		return "";
	}
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return value; 
}

function getNullToEmpty(str){
	if(str==undefined){
		return "";
	}else{
		return str;
	}
}

function getToday(){
	var d = new Date();

	var month = d.getMonth()+1;
	var day = d.getDate();

	return d.getFullYear() + '-' + (month<10 ? '0' : '') + month + '-' +(day<10 ? '0' : '') + day;
}


 function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
 }

 function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
 }

 function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
 }