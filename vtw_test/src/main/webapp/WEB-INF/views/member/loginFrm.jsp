<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    


<div id = "container-loginFrm">
	<form
		id="loginfrm">
		
		<div id = "input_id">
			<label>아이디</label>
			<input type="text" name="id" id = "userid">
		</div>
		
		<div id = "input_pwd">
			<label>비밀번호</label>
			<input type="password" name="pwd" id = "userpwd">
		</div>
		
		<div id = "btn-login">
			<input type="submit" value="로그인" id = "btn-signIn">
			<input type="button" value="회원가입"id= "btn-signUp">
		</div>
	</form>
</div>

<script>


$(function(){ 
	
	$("#vtwLogo").css({"left" : "46%"});
});


$(loginfrm).submit((e) => {
	e.preventDefault();
	const id = $(e.target).find("[name=id]").val();
	const pwd = $(e.target).find("[name=pwd]").val();
	
	
	$.ajax({
		url:"${pageContext.request.contextPath}/memberRest/signIn",
		method:"GET",
		data:{
			"id" : id,
			"pwd" : pwd
		},
		success: function(errCount){
			console.log(errCount);
			if(errCount == 0){
				location.href = "${pageContext.request.contextPath}/member/signIn?id="+id;
			}
			else{
				//로그인 or 비밀번호가 틀렷을때 실행할코드 작성
			}
			
			
		},
		error: console.log
	});
	
	

	
});

$("#btn-signUp").click((e) => {
	
	location.href = "${pageContext.request.contextPath}/member/signUp"
	
});


/*
 * 
 let section;

	let hd = 
	`<header>
		<h1>\${member.name}님 환영합니다.</h1>
		<input type='hidden' value='\${member.name}' id = 'loginMember'>
		<button type = 'button' id = 'btn-signOut' onclick = 'logout();'>로그아웃</button>
	</header>`;
	
	section = `<button type = 'button' onclick = 'searchBoard();'>게시글 조회</button>`;
	section += `<button type = 'button' onclick = 'createBoard();'>글쓰기</button>`;
	
	$("#container-loginFrm").remove();
	$("#header-container").html(hd);
	$("#container-board").html(section);
 */
 
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>