<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    



<div class="boardFrm-container">
	<h3>게시글 작성</h3>

	<form 
		id = "insertBoard">
		
		<table class="boardFrm-table">
			<tbody>
				<tr>
					<th>작성자</th>
					<td colspan="3">${member.name}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea rows="5" cols="80" maxlength="1900" name="content"></textarea></td>
				</tr>
			</tbody>
		</table>

		<button>작성</button>
		<input type="hidden" value="${member.id}" name = "memberId">
	</form>

</div>



<script>

$(insertBoard).submit((e) => {
	e.preventDefault();
	
	const title = $(e.target).find("[name=title]").val();
	const content = $(e.target).find("[name=content]").val();
	const memberId = $(e.target).find("[name=memberId]").val();
	if(title == ""){
		alert("제목을 입력하세요.");
	}
	else if(content == ""){
		alert("내용을 입력하세요.");
	}
	
	else{
		
		$.ajax({
			url:"${pageContext.request.contextPath}/boardRest/insertBoard",
			method:"POST",
			data:{
				"title" : title,
				"content" : content,
				"memberId" : memberId
			},
			success: function(errCount){
				
				if(errCount == 1){
					location.href = "${pageContext.request.contextPath}/board/backToIndex";
				}
				else{
					alert("게시글 등록 실패");
				}
				
				
			},
			error: console.log
		});
		
	}
	
	
	
	
	

	
});
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>