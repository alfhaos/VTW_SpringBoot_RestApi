<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
$(() => {
	
	$("#content").on('keydown keyup', function () {
		  $(this).height(5).height( $(this).prop('scrollHeight')+12 );	
	});
	
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
					title,
					content,
					memberId
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
});
</script>
<div class="boardFrm-container">
	<h3>게시글 작성</h3>

	<form method="post" enctype="multipart/form-data" id="insertBoard">

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
					<td colspan="3"><textarea maxlength="1900" id="content"
							name="content"></textarea></td>
				</tr>
				<tr>
					<th>파일 첨부</th>
					<td><input type="file" id= "file" name= "file" multiple="multiple" accept="*"></td>
				</tr>
			</tbody>
		</table>

		<button>작성</button>
		<input type="hidden" value="${member.id}" name="memberId">
	</form>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>