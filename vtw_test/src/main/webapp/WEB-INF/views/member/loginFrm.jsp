<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>

$(function(){ 
	
	$("#vtwLogo").css({"left" : "46%"});

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
				}
				
				
			},
			error: console.log
		});
		
	});
	
	$("#btn-signUp").click((e) => {
		
		location.href = "${pageContext.request.contextPath}/member/signUp"
		
	});
});
</script>
  
<div id = "container-loginFrm">
	<form
		id="loginfrm">
		
		<div id = "input_id">
			<label>아이디</label>
			<input type="text" name="id" id = "userid" value="alfhaos">
		</div>
		
		<div id = "input_pwd">
			<label>비밀번호</label>
			<input type="password" name="pwd" id = "userpwd" value="1234">
		</div>
		
		<div id = "btn-login">
			<input type="submit" value="로그인" id = "btn-signIn">
			<input type="button" value="회원가입"id= "btn-signUp">
		</div>
	</form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>