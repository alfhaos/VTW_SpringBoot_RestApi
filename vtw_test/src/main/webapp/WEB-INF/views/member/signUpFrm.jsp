<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    

<form 
	id="signUpFrm">
	<div id="container-signUp">
		<div id = "signUp-Group-1">
			<p>아이디</p>
			<div id="signUp-Group-id">
				<span id="box_id">
					<input type="text" name="id" id="id" maxlength="12">
				</span>
				<span id = "error_span_id"></span>
				<!-- <button type="button" id="idCheck">중복확인</button> -->
			</div>

		</div>
		<div id = "signUp-Group-2">
			<p id="signUpFrm-pwd">비밀번호</p>
			<span id="box_pwd">
				<input type="password" name="pwd" id = "pwd" maxlength="16">
			</span>
			<span id = "error_span_pwd"></span>
			
			
			<p id="pwdck">비밀번호 확인</p>
			<span id="box_pwdck">
				<input type="password" name="pwdCheck" id = "pwdCk">
			</span>
			<span id = "error_span_pwdCk"></span>
		</div>
		
		<div id = "signUp-Group-3">
			<p>이름</p>
			<span id="box_name">
				<input type="text" name="name" id = "userName" maxlength="10">
			</span>
			<span id = "error_span_name"></span>
		</div>
		
		
		<div id = "signUp-Group-btn">
			<button id="signUp-btn">회원가입</button>
			<button type="button" id="signUpCancel-btn" onclick="location.href='${pageContext.request.contextPath}/member/logout'">취소</button>
		</div>
	</div>
</form>



<script>

	
	let IdCheck = false;
	let pwdCheck = false;
	let idErrorCount = 1;
	let pwdErrorCount = 1;
	let pwdCkErrorCount = 1;
	let nameErrorCount = 1;
	
	let userPwd;
	
	
	// 정규 표현식
	const idRegExp = /^[a-z]{4,12}$/;
	const pwdRegExp = /[a-zA-Z0-9]{8,16}$/;
	const nameRegExp = /[가-힣a-zA-Z]/;
	const spRegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
	
	$("#userName").focusout(function() {
		let userName = $("#userName").val();
		
		if(userName == ""){
			error_span_name.innerText = "필수 입력사항입니다.";
			nameErrorCount = 1;
		}
		else if(nameRegExp.test(userName)){
			error_span_name.innerText = "";
			nameErrorCount = 0;
		}
		else{
			error_span_name.innerText = "한글과 영문 대 소문자를 이용하세요.";
			nameErrorCount = 1;
		}
		
		
	});
	
	$("#pwdCk").focusout(function() {
		
		let userPwdCk = $("#pwdCk").val();
		
		if(userPwdCk == ""){
			error_span_pwdCk.innerText = "필수 입력사항입니다.";
			pwdCkErrorCount = 1;
		}
		else if(userPwdCk != userPwd){
			error_span_pwdCk.innerText = "비밀번호가 일치하지 않습니다.";
			ppwdCkErrorCount = 1;
		}
		else if(userPwdCk == userPwd){
			error_span_pwdCk.innerText = "";
			if(pwdCheck){
				pwdCkErrorCount = 0;
				pwdErrorCount = 0;
			}

		}
		

		
	});
	
	$("#pwd").focusout(function() {
		
		userPwd = $("#pwd").val();
		
		
		if(userPwd == ""){
			error_span_pwd.innerText = "필수 입력사항입니다.";
			pwdErrorCount = 1;
		}
		else if(!pwdRegExp.test(userPwd)){
			error_span_pwd.innerText = "8~16자 영문 대 소문자, 숫자를 사용하세요.";
			pwdErrorCount = 1;
		}
		else if(pwdRegExp.test(userPwd)){
			error_span_pwd.innerText = "";
			pwdErrorCount = 0;
			pwdCheck = true;
		}
		
		
	});
	
	
	$("#id").focusout(function() {

		var userId = $("#id").val();
		var advice = $(".error_span_id");
		
		
		if(userId == ""){
			error_span_id.innerText = "필수 입력사항입니다.";
			idErrorCount = 1;
		}

		else if(!idRegExp.test(userId)){
			error_span_id.innerText = "영문 4~12자리로 입력하세요.";
			idErrorCount = 1;
		}
		else if(idRegExp.test(userId)){

			$.ajax({
				url : "${pageContext.request.contextPath}/memberRest/checkId",
				type : "GET",
				data : {
					id : userId
				},
				success : function(data){
					if(data == ""){
						error_span_id.innerText = "사용가능한 아이디 입니다.";
						
						idErrorCount = 0;
					}
					else{
						error_span_id.innerText = "이미 사용중인 아이디입니다.";
						idErrorCount = 1;
					}
				},
				error : console.log
			});
		}
		
	});
	
	
	$(signUpFrm).submit((e) => {
		e.preventDefault();
		
		const id = $(e.target).find("[name=id]").val();
		const pwd = $(e.target).find("[name=pwd]").val();
		const name = $(e.target).find("[name=name]").val();
		
		if(idErrorCount == 0 && pwdErrorCount == 0 && pwdCkErrorCount == 0 && nameErrorCount == 0){
			
			$.ajax({
				url:"${pageContext.request.contextPath}/memberRest/insertMember",
				method:"POST",
				data:{
					"id" : id,
					"pwd" : pwd,
					"name" : name
				},
				success: function(resp){
					
					if(resp == 1){
						alert("회원 등록 성공");
						location.href = "${pageContext.request.contextPath}/member/logout";
					}

					
				},
				error: console.log
			});
			
		}
		else {
			if(idErrorCount == 1){
				error_span_id.innerText = "사용 불가능한 아이디 입니다.";
			}
			else if(pwdErrorCount == 1){
				error_span_pwd.innerText = "사용 불가능한 비밀번호 입니다.";	
			}
			else if(nameErrorCount == 1){
				error_span_name.innerText = "사용 불가능한 이름 입니다.";
			}
			else if(pwdCkErrorCount == 1){
				error_span_pwdCk.innerText = "비밀번호가 일치하지 않습니다.";
			}
		};
		
		
		
		
	});
	
	
	$("#idCheck").click((e) => {
		var id = $("#id").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/memberRest/checkId",
			method:"GET",
			data:{
				"id" : id
			},
			success(resp){
				if(resp != null){
					alert("해당 아이디는 사용하실수 없습니다.");
				}
				else{
					IdCheck = true;
					alert("해당 아이디는 사용가능 합니다.");
				}
			},
			error: console.log
		});
	});
	
	
	

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

	