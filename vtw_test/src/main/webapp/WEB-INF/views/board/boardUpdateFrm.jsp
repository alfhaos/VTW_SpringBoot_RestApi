<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
$(() => {

	$("#content").height(5).height( $("#content").prop('scrollHeight')+12 );	

	$(updateFrmDB).submit((e) => {
		e.preventDefault();
		
		const title = $("#title").val();
		const content = $("#content").val();
		const num = $("#num").val();
	
		$.ajax({
			url:"${pageContext.request.contextPath}/boardRest/boardUpdate",
			method:"POST",
			data:{
				"title" : title,
				"content" : content,
				"num" : num
			},
			success: function(resp){
				if(resp == 1){
					location.href = "${pageContext.request.contextPath}/board/boardDetail?num="+num;
				}
				
			},
			error: console.log
		});
	});
	
});
</script>
<div class="boardFrm-container">
	<h3>게시글 수정</h3>

	<form 
		id = "updateFrmDB">
		
		<table class="boardFrm-table">
			<tbody>
				<tr>
					<th>작성자</th>
					<td colspan="3">${member.name}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" value="${board.title}" id="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea maxlength="1900" id="content">${board.content}</textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" value="${board.writer}" id="writer">
		<input type="hidden" value="${board.num}" id="num">
		<button>수정</button>
	</form>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>