<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    

<h2>메인 게시판</h2>

<div class="main_board_container">

	<table class="main_table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="board" items="${boardList}">
			<tr data-no = "${board.num}" onclick="">
				<td>${board.num}</td>
				<td>${board.title}</td>
				<td>${board.writer}</td>
				<td>${board.formatDate}</td>
				<td>${board.readCount}</td>
			</tr>
		</c:forEach>
	</table>
</div>

<button type="button" onclick="location.href='${pageContext.request.contextPath}/board/form'">글쓰기</button>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>