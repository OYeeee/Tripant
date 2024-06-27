$(loadedHanlder);
//세션스토리지값 저장
let editStorage = window.sessionStorage;

//장소 정보를 담을 객체 생성
//constructor : 값이 null이어도 해당 key의 공간을 확보해둠
/*class SpotInfo {
    constructor() {
        this.planId = null;
        this.day = null;
        this.stayTime = null;
        this.travelOrder = null;
        this.title = null;
        this.memo = null;
        this.lat = null;
        this.lng = null;
        this.startTime = null;
        this.endTime = null;
    }
}*/


function loadedHanlder(){
	var url = window.location.pathname;
	var param = window.location.search;
	console.log("==??"+url);
	$.ajax({
		url: url+"/info",
		method:"post",
		dataType:"json",
		success : function(dayEntityList) {
	        dayEntityList_org = dayEntityList;
			setEvent();
        }
	});
}

function setEvent(){
	//화면에 뿌릴 장소 정보 백틱으로 한번에 담아오기
	displayInfo();

	//장소별 머무는 시간 출력
	//staytimeHandler();

	//map 화면 출력
	displayMap();
	//setBounds();
	
	//일차별 동그라미 색 변경
	circleColorHandler();
	
	//좌측 탭 이벤트 설정
	navHandler();

	displayEditInfo();
	

	//드래그 앤 드랍
	dragAndDrop();

	//편집
	$(".edit").click(editHandler);
	//편집 취소
	$(".cancel").click(cancelHandler);
	//편집 저장
	$(".save").click(saveHandler);
	//hover 시 메모내용 표시
	$(".img-memo").hover(memoHandler,memoNoHandler);

}
