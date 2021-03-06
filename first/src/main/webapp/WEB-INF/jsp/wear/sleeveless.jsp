<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Main 상의</title>
	<%@ include file="/WEB-INF/include/include-header-first.jspf" %>
</head>
<body>
	<header id="header">
		<div class="inner">
			<a href="#this" id="home"><h2>What Do I Wear Today?</h2></a>
			<a href="#this" class="btn" id="logout">로그아웃  </a>
			<a href="#this" class="btn" id="closet">  내 옷장  </a>
		</div>
	아이디 : ${sessionScope.user.ID } 성별 : ${sessionScope.user.SEX } 레벨 : ${sessionScope.user.MEM_LEVEL }<br> ${sessionScope.closet.MAIN }<br>${sessionScope.closet.SMALL }
	</header>
	
	<table class="top">
		<tr>
			<td><img src="./../../resources/images/031-sleeveless.png" /></td>	
		</tr>		
		<c:forEach var="row" items="${list}">
			<tr>
				<td><img src="./../../resources/images/file/${row}" /></td>
			</tr>
		</c:forEach>
		<tr><td><a href="#this" class="btn" id="cameraplus"><img style="height:250px; width:250px" src="./../../resources/images/plus-button.png" /></a></td></tr>
	</table>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>

<script>
$(document).ready(function(){
	$("#logout").on("click", function(e){
        e.preventDefault();
        fn_logout();
   });
	$("#closet").on("click", function(e){
        e.preventDefault();
        fn_showMyCloset();
    });
	$("#cameraplus").on("click", function(e){
        e.preventDefault();
        fn_addCameraPic();
   });	
	$("#home").on("click", function(e){
        e.preventDefault();
        goHome();
   });	
});
   
function goHome(){
	var comSubmit = new ComSubmit();
	comSubmit.setUrl("<c:url value='/wear/weathertest.do' />");
	   comSubmit.submit();
}
    
function fn_logout(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/logout.do' />");
	   comSubmit.submit();
	}
	
function fn_showMyCloset(){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='/wear/mycloset.do' />");
    comSubmit.submit();
}
function fn_addCameraPic(){
	   var comSubmit = new ComSubmit();
	   comSubmit.setUrl("<c:url value='/wear/camera.do' />");
	   comSubmit.submit();
	}</script>

</body>
</html>
