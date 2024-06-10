$(loadedHandler);

function loadedHandler() {
	$(".btn").on("click", ClickHandler);
}

function ClickHandler() {
	console.log("++");
	Swal.fire({
         title: " <p style='font-size:17px'>" + "등급변경" + "</p>",
         confirmButtonText:"수정완료",
         confirmButtonColor:"black",
         width:"280px",
         confirmButtonTextFont:"Binggrae",
         html: `
             <select name="selectRole" id="selectRole" style='font-family:Binggrae; font-size:13px; height:25px'>
                 <option value="1">휴먼회원</option>
                 <option value="2">일반회원</option>
                 <option value="3">폰튼적용회원</option>
                 <option value="4">관리자</option>
                 <option value="5">소유자</option>
             </select>
         `,
         focusConfirm: false,
         preConfirm: () => {  //확인 버튼 누르면 실행되는 콜백함수
             const selectRole = document.getElementById('selectRole').value;
             $.ajax({
            	 url:"/admin/member/role",
            	 method:"post",
            	 data: {selectRole:selectRole},
				 //success: 1이면 업데이트 완료 0이면 실패
				 success : function(result) {
							console.log(result);
							if (result == 1 ) {
								alert("성공");
							} else {
								alert("실패");
							}
				 },
				 error : function(request, status, error) {
							alert("code: " + request.status + "\n"
									+ "message: " + request.responseText + "\n"
									+ "error: " + error);
						}
             });
             return { selectRole: selectRole };
         }
     }).then((result) => {  
         if (result.isConfirmed) { //모달창에서 confirm 버튼을 눌렀다면
             console.log('Selected Role:', result.value.selectRole);
         }
     });
	 
}
