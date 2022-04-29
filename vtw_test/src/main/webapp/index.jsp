<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	
function inputBoard(){
		
		const title = $("#title").val();
		const content = $("#content").val();
		
		$.ajax({
			url:`${pageContext.request.contextPath}/boardRest/inputBoardFrm/\${title}/\${content}`,
			method:"POST",
			success(resp){	
				if(resp == 1){
					alert("게시글 등록 성공");
					$("#boardFrm-container").remove();
					searchBoard();
				}
				else{
					alert("게시글 등록 실패");
				}
			},
			error: console.log
		});
		
}
	
function createBoard(){
		location.href = "${pageContext.request.contextPath}/board/boardFrm";
}
	
function searchBoard(){
		$("#first").prop('checked',true);
		
		$.ajax({
			url:"${pageContext.request.contextPath}/boardRest/selectAllBoard",
			method:"GET",
			success(resp){
				
				var mapBoard = resp.board;
				var pageBar = resp.pagebar;
				var len = mapBoard.length;
			
				let boardList = 
					`<div id = "container-board-list">
						<table class="main_table">
							<tr>
								<th>번호</th>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>`;
							
				if(len){
								
					$(mapBoard).each((i,board) => {
						const {num,title,writer,formatDate,readCount} = board;
							boardList +=
								`<tr data-no = \${num} onclick='boardDetail(\${num})' class = "list_tr">
									<td>\${num}</td>	
									<td>\${writer}</td>
									<td>\${title}</td>
									<td>\${formatDate}</td>
									<td>\${readCount}</td>
								</tr>`;
					});
					
					boardList +=
						`</table>
						</div>`;
						
					$("#pageBar").remove();
					$("#container-pagebar").append(pageBar);

				}
		      	else {
		      		boardList += `<tr><td colspan='6'>검색된 결과가 없습니다.</td></tr>`;	        		
	        	}	
				
				$("#container-board-list").remove();
				$("#board_detail_container").remove();
				$("#container-board-main").append(boardList);	
				
			},
			error: console.log
		});
}
function boardDetail(num){

		location.href = "${pageContext.request.contextPath}/board/boardDetail?num="+num;

}
	
$(function(){ 
		
		searchBoard();

	
	$("input[name='choice']:radio").change(function(e) {
		var radio = $(e.target).val();
		
		if(radio == 'last'){
			
			searchBoard();
			
		}
		else if(radio == 'readCount'){
			$.ajax({
				url:"${pageContext.request.contextPath}/boardRest/selectBoardReadCount",
				method:"GET",
				success(resp){	
					
					var mapBoard = resp.board;
					var pageBar = resp.pagebar;
					var len = mapBoard.length;
					
					displayBoard(mapBoard,pageBar,len);
					
				},
				error: console.log
			});
		}
		
		else if(radio == 'user_board'){
			$.ajax({
				url:"${pageContext.request.contextPath}/boardRest/selectBoardUser",
				method:"GET",
				success(resp){	
					
					var mapBoard = resp.board;
					var pageBar = resp.pagebar;
					var len = mapBoard.length;
					
					displayBoard(mapBoard,pageBar,len);
					
				},
				error: console.log
			});
			
		}
		
	});
});

function displayBoard(mapBoard,pageBar,len){
		
		var mapBoard = mapBoard;
		var pageBar = pageBar;		
		var len = len;
		
		console.log(mapBoard);
		console.log(pageBar);
		console.log(len);
		
		let boardList = 
			`<div id = "container-board-list">
				<table class="main_table">
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>`;
					
		if(len){
						
			$(mapBoard).each((i,board) => {
				const {num,title,writer,formatDate,readCount} = board;
					boardList +=
						`<tr data-no = \${num} onclick='boardDetail(\${num})' class = "list_tr">
							<td>\${num}</td>	
							<td>\${writer}</td>
							<td>\${title}</td>
							<td>\${formatDate}</td>
							<td>\${readCount}</td>
						</tr>`;
			});
			
			boardList +=
				`</table>
				</div>`;
			$("#pageBar").remove();

		}
      	else {
      		boardList += `<tr><td colspan='6' id = 'empty'>검색된 결과가 없습니다.</td></tr>`;	
      		$("#pageBar").remove();
    	}	

		$("#container-board-list").remove();
		$("#board_detail_container").remove();
		$("#container-board-main").append(boardList);	
		$("#container-pagebar").append(pageBar);
}
	
</script>    
	<div id = "container-board">
		<div id = "container-board-choice">
			<input type="radio" name = "choice" value = "last" checked="checked" id="first">최신순
			<input type="radio" name = "choice" value = "readCount">조회순
			<input type="radio" name = "choice" value = "user_board">나의 게시글
		</div>
		<% if(member != null){ %>	
			<button type = 'button' onclick = 'searchBoard();'>
				<span class="material-icons">
					autorenew
				</span>
			</button>
			<button type = 'button' onclick = 'createBoard();' id="create_board">글쓰기</button>
		<%}%>
	</div>
	
	<div id = "container-board-main">
	
	</div>
	<div id = "container-pagebar">

	</div>

</section>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

	

