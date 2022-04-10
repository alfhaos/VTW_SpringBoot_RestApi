<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="board_detail_container">

	<table class="table_board">

		<thead>
			<tr>
				<th colspan="4" id="table_title">
					<div class="container_detail_title">
						<span id="detail_title"> ${board.title} </span>
					</div>
				</th>
			</tr>
		</thead>

		<tbody id="bb">
			<tr>
				<th>작성자</th>
				<td>${board.writer}</td>
				<th>등록일</th>
				<td>${board.formatDate}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td colspan="3">${board.readCount}</td>
			</tr>
			<tr>
				<td colspan="4">
					<div class="board_content">${board.content}</div>
				</td>
			</tr>
		</tbody>

	</table>
	<input type="hidden" id="board_num" value="${board.num}">

	<c:if test="${board.writer eq member.name}">
		<button type="button" value="${board.num}" id="btn-update">수정</button>
		<button type="button" value="${board.num}" id="btn-delete">삭제</button>
	</c:if>


	<div class="board_comment_container">

		<input type="text" class="comment" placeholder="댓글을 입력해주세요"
			maxlength="50">
		<button type="button" id="comment_btn">등록</button>


		<div class="board_comment_list">
			<ul id="ul_list">
				<c:forEach var="comment" items="${commentList}">
					<li id="${comment.commentNum}">
						<div class='list_writer'>${comment.writer}</div>
						<div class='list_date'>${comment.formatDate}</div>
						<div class='list_content' id="content_${comment.commentNum}">${comment.content}</div>
						<c:if test="${comment.memberId eq member.id}">
							<div class="list_btn" id="btnGroup_${comment.commentNum}">
								<button value="${comment.commentNum}" class="comment_update"
									onclick='commentUpdate(${comment.commentNum});'>수정</button>
								<button value="${comment.commentNum}" class="comment_delete"
									onclick='commentDelete(${comment.commentNum});'>삭제</button>
							</div>
						</c:if>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>


<script>

const num = $("#board_num").val();
// header에서 선언한 로그인멤버 아이디 담은거 가져온것
const loginMemberId = $("#loginMemberId").val();

$("#comment_btn").click((e) => {
	
	var comment = $(".comment").val();
	
	// ajax을 통해 등록하고 반환값으로 댓글 목록을 반환하면 등록하고 다시 갱신되는거까지 볼수있는 미뤄클
	$.ajax({
		url:`${pageContext.request.contextPath}/boardRest/insertComment`,
		method:"POST",
		data:{
			content : comment,
			boardNum : num
		},
		success(commentList){	
			var clist = "";
			
			displayComment(commentList,clist,loginMemberId);
		},
		error: console.log
	});
	
	
});


$("#btn-delete").click((e) => {

	
	if(confirm("해당 게시물을 삭제하시겠습니까?")){
		var url = "${pageContext.request.contextPath}/board/boardDelete"
		var num = $(e.target).val();
		var form;
		
		form += '<form name="boardDeleteForm" action="'+url+'" method="post">';
		form += '<input type="hidden" name="num" value="'+num+'" />';
		form += '</form>';
		
		$(".board_detail_container").append(form);
		document.boardDeleteForm.submit();
		
		
	}
});

$("#btn-update").click((e) => {
	
	if(confirm("해당 게시물을 수정하시겠습니까?")){

		var num = $(e.target).val();
		var url = "${pageContext.request.contextPath}/board/boardUpdate?num="+num
				
				
		location.href = url;		

	}
});





function displayComment(commentList,clist,loginMemberId){
	if(commentList != null){
		
		$(commentList).each((i,comment) => {
			const {writer,content,formatDate,commentNum,boardId,memberId} = comment;
			var id = comment.memberId;
			var co = comment.content;
			
			if(loginMemberId == id){
	
				clist += 
					`<li id ='\${commentNum}'>
						<div class = 'list_writer'>\${writer}</div>
						<div class = 'list_date'>\${formatDate}</div>
						<div class = 'list_content' id='content_\${commentNum}'>\${content}</div>
	
						<div class = 'list_btn'>
							<button value='\${commentNum}' class = 'comment_update' onclick= 'commentUpdate(\${commentNum});'>수정</button>
							<button value='\${commentNum}' class = 'comment_delete' onclick='commentDelete(\${commentNum});'>삭제</button>
						</div>

					</li>`;
			}
			else{
				
				clist += 
					`<li id = '\${commentNum}'>
						<div class = 'list_writer'>\${writer}</div>
						<div class = 'list_date'>\${formatDate}</div>
						<div class = 'list_content'>\${content}</div>
					</li>`;
			}
			
		});
		
		$("#ul_list").empty();
		$("#ul_list").append(clist);
		$(".comment").val("");
	}
}



function commentUpdateTr(commentnum){
	var commentNum = commentnum;
	var commentContent = $("#updateComment_"+commentNum).val();
	
	
	$.ajax({
		url:`${pageContext.request.contextPath}/boardRest/updateComment`,
		method:"POST",
		data:{
			commentNum : commentNum,
			commentContent : commentContent,
			boardNum : num
		},
		success(commentList){	
			var clist = "";
			
			displayComment(commentList,clist,loginMemberId);

		},
		error: console.log
	});
}

function commentUpdateCancel(commentnum){
	var commentNum = commentnum;
	var commentContent = $("#updateComment_"+commentNum).val();
	
	$("#updateComment_"+commentNum).remove();
	$("#btnGroup_"+commentNum).remove();
	
	let html = `
		<div class = 'list_content' id='content_\${commentNum}'>\${commentContent}</div>
		
		<div class = 'list_btn'>
			<button value='\${commentNum}' class = 'comment_update' onclick= 'commentUpdate(\${commentNum});'>수정</button>
			<button value='\${commentNum}' class = 'comment_delete' onclick='commentDelete(\${commentNum});'>삭제</button>
		</div>
	`;
	
	$("#"+commentNum).append(html);
}

function commentUpdate(commentnum){
	var commentNum = commentnum;
	var commentContent = $("#content_"+commentNum).text();
	
	$("#content_"+commentNum).remove();
	$("#btnGroup_"+commentNum).remove();
	
	let html = `
		<input type='text' id = 'updateComment_\${commentNum}' value='\${commentContent}'>
		
		<div class = "list_btn" id="btnGroup_\${commentNum}">
			<button value="\${commentNum}" class = "comment_update_tr" onclick = "commentUpdateTr(\${commentNum})">확인</button>
			<button value="\${commentNum}" class = "comment_update_cancel" onclick = "commentUpdateCancel(\${commentNum})">취소</button>
		</div>
	`;
	
	$("#"+commentNum).append(html);
}

function commentDelete(commentnum){
	
	var commentNum = commentnum;
	
	
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		$.ajax({
			url:`${pageContext.request.contextPath}/boardRest/deleteComment`,
			method:"POST",
			data:{
				commentNum : commentNum,
				boardNum : num
			},
			success(commentList){	
				var clist = "";
				
				displayComment(commentList,clist,loginMemberId);
				
				
				
			},
			error: console.log
		});
	}
}





</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>