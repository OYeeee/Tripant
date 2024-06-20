//비밀번호 재설정
function setPwdHandler(){
	$.ajax({
		url: contextPath+'pwd', 
		method: 'post', 
		data: $('#frm-pwd').serialize(), 
		success: async function(result){
			if(result === 1){
				const setPwdSuccess = await Swal.fire({
					title: "비밀번호 재설정에 성공하였습니다.\n로그인 페이지로 이동합니다.", 
					icon: "success", 
					confirmButtonColor: "#000000", 
					confirmButtonText: "확인"
				});
				if(setPwdSuccess.isConfirmed){
					location.href = contextPath + 'login';
				}
			}else {
				Swal.fire({
					title: "비밀번호 재설정 중 오류가 발생했습니다.\n관리자에게 문의해주시기 바랍니다.", 
					icon: "error", 
					confirmButtonColor: "#000000", 
					confirmButtonText: "확인"
				});
			}
		}, 
		error: ajaxErrorHandler
	});
}