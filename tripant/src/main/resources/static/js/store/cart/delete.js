// 장바구니 삭제
function cartDelHandler() {
	let items = [];
	$('input:checked').each(function() {
		items.push($(this).val());
	});
	console.log(items);
	$.ajax({
		url : contextPath + 'store/cart/del',
		type : 'post',
		data : {
			items : items
		}, 
		beforeSend: csrfHandler(xhr), 
		success : async function(result) {
			if (result == 1) {
				Swal.fire({
					title: "선택하신 상품이 삭제되었습니다.", 
					icon: "success", 
					confirmButtonText: "확인", 
					confirmButtonColor: "#000000", 
				}).then((swal) => {
					if(swal.isConfirmed){
						location.reload();
					}
				});
			} else {
				Swal.fire({
					title: "상품 삭제 중 오류가 발생했습니다.", 
					icon: "error", 
					confirmButtonText: "확인", 
					confirmButtonColor: "#000000", 
				});
			}
		},
		error : ajaxErrorHandler
	});
}